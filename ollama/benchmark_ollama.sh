#!/bin/bash

# Benchmark script for Ollama models
# Measures Time to First Token (TTFT) and Token Rate (tokens/sec)
# Saves results to a Markdown file

# Create models if required
. create_models.sh

PROMPT="Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."
OUTPUT_FILE="benchmark_results.md"

# Ensure we have the list of models
MODELS=$(ls modelfiles/*Modelfile | sed 's|modelfiles/||;s/-Modelfile//')

mkdir -p benchmark

if [ -z "$MODELS" ]; then
    echo "No models found in ollama/ folder."
    exit 1
fi

# Initialize Markdown file
echo "# Ollama Model Benchmark Results" > "$OUTPUT_FILE"
echo "Date: $(date)" >> "$OUTPUT_FILE"
echo "System Specs:" >> "$OUTPUT_FILE"
echo "- CPU: $(lscpu | grep 'Model name' | sed 's/Model name: //')" >> "$OUTPUT_FILE"
echo "- RAM: $(free -h | awk '/^Mem:/ {print $2}')" >> "$OUTPUT_FILE"
echo "- OS: $(uname -sr)" >> "$OUTPUT_FILE"
echo "- GPU: $(lspci | grep -i 'VGA\|3D' | cut -d ':' -f3- | sed 's/^ *//')" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "Prompt: *\"$PROMPT\"*" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# List of models being benchmarked
echo "## Models Benchmarked" >> "$OUTPUT_FILE"
echo "| Model | Description |" >> "$OUTPUT_FILE"
echo "| :--- | :--- |" >> "$OUTPUT_FILE"
for MODEL in $MODELS; do
    echo "| $MODEL | " >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

for MODEL in $MODELS; do
    echo "Running benchmark for model: $MODEL" >&2
    
    # Create a temporary results file for this model
    TEMP_RESULTS="/tmp/benchmark_results_$MODEL.csv"
    rm -f "$TEMP_RESULTS"
    
    # Initialize variables for averaging
    total_ttft=0
    total_tokens_sec=0
    total_tokens=0
    run_count=0
    token_rates=()
    
    # Run 3 times to get average and jitter
    for RUN in 1 2 3; do
        echo "=== Running $MODEL Run $RUN ===" >&2
        
        # Run the model with verbose output
        RESPONSE=$(ollama run --verbose "$MODEL" "$PROMPT" 2>&1)
        
        # Extract durations and token count from the response using precise patterns
        PROMPT_EVAL_DURATION=$(echo "$RESPONSE" | sed -n 's/^prompt eval duration: *//p' | head -1)
        EVAL_DURATION=$(echo "$RESPONSE" | sed -n 's/^eval duration: *//p' | head -1)
        EVAL_COUNT=$(echo "$RESPONSE" | sed -n 's/^eval count: *//p' | head -1)
        PROMPT_EVAL_RATE=$(echo "$RESPONSE" | sed -n 's/^prompt eval rate: *//p' | head -1)
        EVAL_RATE=$(echo "$RESPONSE" | sed -n 's/^eval rate: *//p' | head -1)
        
        # Debug output for raw values
        echo "DEBUG: PROMPT_EVAL_DURATION extracted as '$PROMPT_EVAL_DURATION'" >&2
        echo "DEBUG: PROMPT_EVAL_RATE extracted as '$PROMPT_EVAL_RATE'" >&2
        echo "DEBUG: EVAL_RATE extracted as '$EVAL_RATE'" >&2
        
        # Convert prompt eval duration to seconds if it's in milliseconds
        TTFT="N/A"
        if [[ ! -z "$PROMPT_EVAL_DURATION" ]]; then
            if [[ "$PROMPT_EVAL_DURATION" =~ ^[0-9.]+ms$ ]]; then
                # Convert milliseconds to seconds
                TTFT_NUM=$(echo "$PROMPT_EVAL_DURATION" | sed 's/ms//')
                TTFT=$(echo "scale=6; $TTFT_NUM / 1000" | bc -l 2>/dev/null)
            elif [[ "$PROMPT_EVAL_DURATION" =~ ^[0-9.]+s$ ]]; then
                # Already in seconds
                TTFT=$(echo "$PROMPT_EVAL_DURATION" | sed 's/s//')
            else
                # Assume it's already a number in seconds or invalid format
                TTFT="$PROMPT_EVAL_DURATION"
            fi
            
            # Validate that we got a valid number for TTFT
            if [[ $TTFT =~ ^[0-9]*\.?[0-9]+$ ]] && [[ ! -z "$TTFT" ]]; then
                echo "DEBUG: Converted TTFT to '$TTFT' seconds" >&2
            else
                TTFT="N/A"
                echo "DEBUG: Invalid TTFT value '$PROMPT_EVAL_DURATION', setting to N/A" >&2
            fi
        fi
        
        # Handle prompt evaluation rate
        if [[ ! -z "$PROMPT_EVAL_RATE" ]]; then
            # Extract numeric value from rate (e.g., "54.59 tokens/s" -> 54.59)
            PROMPT_RATE_NUM=$(echo "$PROMPT_EVAL_RATE" | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
            # Validate that we got a valid number
            if [[ $PROMPT_RATE_NUM =~ ^[0-9]*\.?[0-9]+$ ]] && [[ ! -z "$PROMPT_RATE_NUM" ]]; then
                PROMPT_RATE="$PROMPT_RATE_NUM"
            else
                PROMPT_RATE="N/A"
                echo "DEBUG: Invalid PROMPT_RATE_NUM '$PROMPT_RATE_NUM' for PROMPT_EVAL_RATE '$PROMPT_EVAL_RATE'" >&2
            fi
        fi
        
        # Handle eval rate (output tokens/sec)
        if [[ ! -z "$EVAL_RATE" ]]; then
            # Extract numeric value from rate (e.g., "224.68 tokens/s" -> 224.68)
            EVAL_RATE_NUM=$(echo "$EVAL_RATE" | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
            # Validate that we got a valid number
            if [[ $EVAL_RATE_NUM =~ ^[0-9]*\.?[0-9]+$ ]] && [[ ! -z "$EVAL_RATE_NUM" ]]; then
                EVAL_RATE_VAL="$EVAL_RATE_NUM"
                TOKEN_RATE="$EVAL_RATE_NUM"
            else
                EVAL_RATE_VAL="N/A"
                TOKEN_RATE="N/A"
                echo "DEBUG: Invalid EVAL_RATE_NUM '$EVAL_RATE_NUM' for EVAL_RATE '$EVAL_RATE'" >&2
            fi
        fi
        
        # If eval rate is not available, calculate it manually
        if [[ -z "$EVAL_RATE" && ! -z "$EVAL_DURATION" && ! -z "$EVAL_COUNT" ]]; then
            EVAL_COUNT_NUM=$(echo "$EVAL_COUNT" | sed 's/ token(s)//' | sed 's/[^0-9.]//g')
            EVAL_DURATION_NUM=$(echo "$EVAL_DURATION" | sed 's/s//')
            if (( $(echo "$EVAL_DURATION_NUM > 0" | bc -l) )) && [[ $EVAL_COUNT_NUM =~ ^[0-9]*\.?[0-9]+$ ]] && [[ ! -z "$EVAL_COUNT_NUM" ]]; then
                TOKEN_RATE=$(echo "scale=2; $EVAL_COUNT_NUM / $EVAL_DURATION_NUM" | bc -l)
                EVAL_RATE_VAL="$TOKEN_RATE"
            fi
        fi

        # Append to Markdown table
        printf "| %s | %s | %s | %s | %s |\n" "$RUN" "$TTFT" "$PROMPT_RATE" "$EVAL_RATE_VAL" "$EVAL_COUNT" >> "$OUTPUT_FILE"

        # Store results for averaging and jitter calculation
        if [[ ! -z "$PROMPT_EVAL_DURATION" ]]; then
            total_ttft=$(echo "$total_ttft + $TTFT" | bc -l 2>/dev/null)
            run_count=$((run_count + 1))
        fi
        
        # Only process token rates if they're valid numbers
        if [[ ! -z "$EVAL_COUNT" && ! -z "$EVAL_DURATION" ]]; then
            # Check if we have a valid eval rate value
            if [[ "$EVAL_RATE_VAL" != "N/A" ]] && [[ $EVAL_RATE_VAL =~ ^[0-9]*\.?[0-9]+$ ]]; then
                total_tokens_sec=$(echo "$total_tokens_sec + $EVAL_RATE_VAL" | bc -l 2>/dev/null)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT" | bc -l 2>/dev/null)
                token_rates+=("$EVAL_RATE_VAL")
            elif [[ "$TOKEN_RATE" != "N/A" ]] && [[ $TOKEN_RATE =~ ^[0-9]*\.?[0-9]+$ ]]; then
                # Use manual calculation if available
                total_tokens_sec=$(echo "$total_tokens_sec + $TOKEN_RATE" | bc -l 2>/dev/null)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT" | bc -l 2>/dev/null)
                token_rates+=("$TOKEN_RATE")
            fi
        fi
        
        # Add to temporary results file for final average calculation
        # Format: Model,Run,PromptEvalTime,PromptRate,EvalRate,Tokens
        echo "$MODEL,$RUN,$TTFT,$PROMPT_RATE,$EVAL_RATE_VAL,$EVAL_COUNT" >> "$TEMP_RESULTS"
    done
    
    # Calculate averages for this model
    if [ $run_count -gt 0 ]; then
        avg_ttft=$(echo "scale=4; $total_ttft / $run_count" | bc -l 2>/dev/null)
        avg_tokens_sec=$(echo "scale=2; $total_tokens_sec / $run_count" | bc -l 2>/dev/null)
        avg_tokens=$(echo "scale=0; $total_tokens / $run_count" | bc -l 2>/dev/null)
        
        # If bc failed, set to N/A
        if [[ -z "$avg_ttft" ]]; then avg_ttft="N/A"; fi
        if [[ -z "$avg_tokens_sec" ]]; then avg_tokens_sec="N/A"; fi
        if [[ -z "$avg_tokens" ]]; then avg_tokens="N/A"; fi
        
        # Add average row to output file
        printf "| Average | %s | %s | %s |\n" "$avg_ttft" "$avg_tokens_sec" "$avg_tokens" >> "$OUTPUT_FILE"
    fi

    echo "" >> "$OUTPUT_FILE"
done

# Calculate and display average results table at the end
echo "## Average Results" >> "$OUTPUT_FILE"
echo "| Model | Avg Prompt Eval Time (s) | Avg Prompt Eval Rate (tokens/s) | Avg Eval Rate (tokens/s) | Avg Total Tokens | Jitter (tokens/s) |" >> "$OUTPUT_FILE"
echo "| :--- | :--- | :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"

# Add jitter calculation note before the results table
echo "" >> "$OUTPUT_FILE"
echo "Note: Jitter is calculated as the difference between the highest and lowest tokens/sec values across all runs for each model." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Process the temporary results file to calculate averages by model and include jitter
awk -F',' '
{
    model = $1
    ttft = $3
    prompt_rate = $4
    eval_rate = $5
    tokens = $6
    
    # Skip header line if it exists
    if (model != "Model") {
        if (ttft != "N/A" && ttft ~ /^[0-9]*\.?[0-9]+$/) {
            total_ttft[model] += ttft
            count_ttft[model]++
        }
        if (prompt_rate != "N/A" && prompt_rate ~ /^[0-9]*\.?[0-9]+$/) {
            total_prompt_rate[model] += prompt_rate
            count_prompt_rate[model]++
        }
        if (eval_rate != "N/A" && eval_rate ~ /^[0-9]*\.?[0-9]+$/) {
            total_eval_rate[model] += eval_rate
            count_eval_rate[model]++
        }
        total_tokens[model] += tokens
        count_tokens[model]++
        
        # Store individual token rates for jitter calculation
        if (!(model in run_count_rates)) {
            run_count_rates[model] = 0
        }
        run_count_rates[model]++
        
        if (eval_rate != "N/A" && eval_rate ~ /^[0-9]*\.?[0-9]+$/) {
            if (!(model in rate_array)) {
                rate_array[model] = ""
            }
            if (rate_array[model] == "") {
                rate_array[model] = eval_rate
            } else {
                rate_array[model] = rate_array[model] "," eval_rate
            }
        }
    }
}
END {
    for (model in total_ttft) {
        avg_ttft = total_ttft[model] / count_ttft[model]
        avg_prompt_rate = total_prompt_rate[model] / count_prompt_rate[model]
        avg_eval_rate = total_eval_rate[model] / count_eval_rate[model]
        avg_tokens = total_tokens[model] / count_tokens[model]
        
        # Calculate jitter - difference between max and min token rates
        jitter = 0
        if (rate_array[model] != "") {
            # Split the rates and find min/max
            n = split(rate_array[model], rates, ",")
            if (n > 1) {
                min_rate = rates[1]
                max_rate = rates[1]
                for (i = 2; i <= n; i++) {
                    if (rates[i] < min_rate) min_rate = rates[i]
                    if (rates[i] > max_rate) max_rate = rates[i]
                }
                jitter = max_rate - min_rate
            }
        }
        
        printf "| %s | %.4f | %.2f | %.2f | %.0f | %.2f |\n", model, avg_ttft, avg_prompt_rate, avg_eval_rate, avg_tokens, jitter
    }
}' "$TEMP_RESULTS" >> "$OUTPUT_FILE"

# Clean up temporary file
rm -f "$TEMP_RESULTS"

echo "Benchmark completed. Results saved to $OUTPUT_FILE"