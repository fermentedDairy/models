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
echo "### Models Benchmarked" >> "$OUTPUT_FILE"
for MODEL in $MODELS; do
    echo "- $MODEL" >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

echo "Starting benchmark... Saving results to $OUTPUT_FILE"

# Create a temporary file to store all results for calculating averages
TEMP_RESULTS=$(mktemp)

# Initialize the temporary results file
> "$TEMP_RESULTS"

for MODEL in $MODELS; do
    echo "$MODEL:" >> "$OUTPUT_FILE"
    echo "| Run | TTFT (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens |" >> "$OUTPUT_FILE"
    echo "| :--- | :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"
    
    # Initialize variables for averaging and jitter calculation
    total_ttft=0
    total_tokens_sec=0
    total_tokens=0
    run_count=0
    token_rates=()
    
    for RUN in 1 2 3; do
        echo "" > "benchmark/responses_run${RUN}.txt"
        
        echo "Benchmarking $MODEL (Run $RUN)..."
        
        # Warmup call - this makes sure the model is running and loaded before running the benchmark task
        ollama run "$MODEL" "Say Hello" --verbose > /dev/null 2>&1

        # Run the prompt and capture metrics via Ollama CLI
        RESPONSE=$(ollama run "$MODEL" "$PROMPT" --verbose 2>&1)
        
        # Check if we got a valid response
        if [ -z "$RESPONSE" ]; then
            echo "Warning: Empty response from ollama run for $MODEL (Run $RUN)" >&2
            TTFT="N/A"
            TOKEN_RATE="N/A"
            PROMPT_RATE="N/A"
            EVAL_RATE_VAL="N/A"
            EVAL_COUNT="N/A"
            # Continue to next run instead of failing completely
            continue
        fi

        # Extract durations and token count from the response
        PROMPT_EVAL_DURATION=$(echo "$RESPONSE" | grep "prompt eval duration:" | awk '{print $4}')
        EVAL_DURATION=$(echo "$RESPONSE" | grep "eval duration:" | awk '{print $4}')
        EVAL_COUNT=$(echo "$RESPONSE" | grep "eval count:" | awk '{print $4}')
        PROMPT_EVAL_RATE=$(echo "$RESPONSE" | grep "prompt eval rate:" | awk '{print $4}')
        EVAL_RATE=$(echo "$RESPONSE" | grep "eval rate:" | awk '{print $4}')
        
         # Log raw values for debugging
        echo "=== Raw Response for $MODEL Run $RUN ===" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "PROMPT_EVAL_DURATION: $PROMPT_EVAL_DURATION" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_DURATION: $EVAL_DURATION" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_COUNT: $EVAL_COUNT" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "PROMPT_EVAL_RATE: $PROMPT_EVAL_RATE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_RATE: $EVAL_RATE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "=== Full Response ===" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "$RESPONSE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "===================================" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        
        # Convert durations to seconds if they exist
        TTFT="N/A"
        PROMPT_RATE="N/A"
        EVAL_RATE_VAL="N/A"
        TOKEN_RATE="N/A"
        
        if [[ ! -z "$PROMPT_EVAL_DURATION" ]]; then
            # Parse duration (e.g., "1.520398s")
            TTFT_NUM=$(echo "$PROMPT_EVAL_DURATION" | sed 's/s//')
            TTFT=$(echo "scale=4; $TTFT_NUM" | bc -l)
        fi
        
        # Handle prompt evaluation rate
        if [[ ! -z "$PROMPT_EVAL_RATE" ]]; then
            # Extract numeric value from rate (e.g., "54.59 tokens/s" -> 54.59)
            PROMPT_RATE_NUM=$(echo "$PROMPT_EVAL_RATE" | sed 's/ tokens\/s//')
            # Validate that we got a valid number
            if [[ $PROMPT_RATE_NUM =~ ^[0-9]*\.?[0-9]+$ ]]; then
                PROMPT_RATE="$PROMPT_RATE_NUM"
            else
                PROMPT_RATE="N/A"
            fi
        fi
        
        # Handle eval rate (output tokens/sec)
        if [[ ! -z "$EVAL_RATE" ]]; then
            # Extract numeric value from rate (e.g., "224.68 tokens/s" -> 224.68)
            EVAL_RATE_NUM=$(echo "$EVAL_RATE" | sed 's/ tokens\/s//')
            # Validate that we got a valid number
            if [[ $EVAL_RATE_NUM =~ ^[0-9]*\.?[0-9]+$ ]]; then
                EVAL_RATE_VAL="$EVAL_RATE_NUM"
                TOKEN_RATE="$EVAL_RATE_NUM"
            else
                EVAL_RATE_VAL="N/A"
                TOKEN_RATE="N/A"
            fi
        fi
        
        # If eval rate is not available, calculate it manually
        if [[ -z "$EVAL_RATE" && ! -z "$EVAL_DURATION" && ! -z "$EVAL_COUNT" ]]; then
            EVAL_COUNT_NUM=$(echo "$EVAL_COUNT" | sed 's/ token(s)//' | sed 's/[^0-9.]//g')
            EVAL_DURATION_NUM=$(echo "$EVAL_DURATION" | sed 's/s//')
            if (( $(echo "$EVAL_DURATION_NUM > 0" | bc -l) )) && [[ $EVAL_COUNT_NUM =~ ^[0-9]*\.?[0-9]+$ ]]; then
                TOKEN_RATE=$(echo "scale=2; $EVAL_COUNT_NUM / $EVAL_DURATION_NUM" | bc -l)
                EVAL_RATE_VAL="$TOKEN_RATE"
            fi
        fi

        # Append to Markdown table
        printf "| %s | %s | %s | %s | %s |\n" "$RUN" "$TTFT" "$PROMPT_RATE" "$EVAL_RATE_VAL" "$EVAL_COUNT" >> "$OUTPUT_FILE"

        # Log raw values for debugging
        echo "=== Raw Response for $MODEL Run $RUN ===" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "PROMPT_EVAL_DURATION: $PROMPT_EVAL_DURATION" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_DURATION: $EVAL_DURATION" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_COUNT: $EVAL_COUNT" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "PROMPT_EVAL_RATE: $PROMPT_EVAL_RATE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "EVAL_RATE: $EVAL_RATE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "=== Full Response ===" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "$RESPONSE" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"
        echo "===================================" >> "benchmark/$MODEL/response_run${RUN}_debug.txt"

        # Store results for averaging and jitter calculation
        if [[ ! -z "$PROMPT_EVAL_DURATION" ]]; then
            total_ttft=$(echo "$total_ttft + $TTFT" | bc -l)
            run_count=$((run_count + 1))
        fi
        
        # Only process token rates if they're valid numbers
        if [[ ! -z "$EVAL_COUNT" && ! -z "$EVAL_DURATION" ]]; then
            # Check if we have a valid eval rate value
            if [[ "$EVAL_RATE_VAL" != "N/A" ]] && [[ $EVAL_RATE_VAL =~ ^[0-9]*\.?[0-9]+$ ]]; then
                total_tokens_sec=$(echo "$total_tokens_sec + $EVAL_RATE_VAL" | bc -l)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT" | bc -l)
                token_rates+=("$EVAL_RATE_VAL")
            elif [[ "$TOKEN_RATE" != "N/A" ]] && [[ $TOKEN_RATE =~ ^[0-9]*\.?[0-9]+$ ]]; then
                # Use manual calculation if available
                total_tokens_sec=$(echo "$total_tokens_sec + $TOKEN_RATE" | bc -l)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT" | bc -l)
                token_rates+=("$TOKEN_RATE")
            fi
        fi
        
        # Add to temporary results file for final average calculation
        echo "$MODEL,$RUN,$TTFT,$PROMPT_RATE,$EVAL_RATE_VAL,$EVAL_COUNT" >> "$TEMP_RESULTS"
    done
    
    # Calculate averages for this model
    if [ $run_count -gt 0 ]; then
        avg_ttft=$(echo "scale=4; $total_ttft / $run_count" | bc -l)
        avg_tokens_sec=$(echo "scale=2; $total_tokens_sec / $run_count" | bc -l)
        avg_tokens=$(echo "scale=0; $total_tokens / $run_count" | bc -l)
        
        # Add average row to output file
        printf "| Average | %s | %s | %s |\n" "$avg_ttft" "$avg_tokens_sec" "$avg_tokens" >> "$OUTPUT_FILE"
    fi
    
    # Calculate jitter (difference between max and min tokens/sec across runs)
    if [ ${#token_rates[@]} -ge 2 ]; then
        # Sort token rates to find min and max
        IFS=$'\n' sorted_rates=($(sort -n <<<"${token_rates[*]}"))
        unset IFS
        
        min_rate=${sorted_rates[0]}
        max_rate=${sorted_rates[-1]}
        # Ensure we have valid numeric values before calculating
        if [[ $min_rate =~ ^[0-9]*\.?[0-9]+$ ]] && [[ $max_rate =~ ^[0-9]*\.?[0-9]+$ ]]; then
            jitter=$(echo "scale=2; $max_rate - $min_rate" | bc -l)
            
            echo "" >> "$OUTPUT_FILE"
            echo "Jitter (max - min tokens/sec): $jitter" >> "$OUTPUT_FILE"
            echo "Note: Jitter is calculated as the difference between the highest and lowest tokens/sec values across all runs for this model." >> "$OUTPUT_FILE"
        fi
    fi
    
    echo "" >> "$OUTPUT_FILE"
done

# Calculate and display average results table at the end
echo "## Average Results" >> "$OUTPUT_FILE"
echo "| Model | Avg TTFT (s) | Avg Prompt Eval Rate (tokens/s) | Avg Eval Rate (tokens/s) | Avg Total Tokens |" >> "$OUTPUT_FILE"
echo "| :--- | :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"

# Process the temporary results file to calculate averages by model
awk -F',' '
{
    model = $1
    ttft = $3
    prompt_rate = $4
    eval_rate = $5
    tokens = $6
    
    # Skip header line if it exists
    if (model != "Model") {
        if (ttft != "N/A") {
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
    }
}
END {
    for (model in total_ttft) {
        avg_ttft = total_ttft[model] / count_ttft[model]
        avg_prompt_rate = total_prompt_rate[model] / count_prompt_rate[model]
        avg_eval_rate = total_eval_rate[model] / count_eval_rate[model]
        avg_tokens = total_tokens[model] / count_tokens[model]
        printf "| %s | %.4f | %.2f | %.2f | %.0f |\n", model, avg_ttft, avg_prompt_rate, avg_eval_rate, avg_tokens
    }
}' "$TEMP_RESULTS" >> "$OUTPUT_FILE"

# Clean up temporary file
rm "$TEMP_RESULTS"

echo "Benchmark complete."
