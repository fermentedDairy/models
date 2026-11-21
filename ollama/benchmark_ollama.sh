#!/bin/bash

# Benchmark script for Ollama models
# Measures Time to First Token (TTFT) and Token Rate (tokens/sec)
# Saves results to a Markdown file

# Create models if required
. create_models.sh

# Note on Jitter Calculation
# Jitter is calculated as the difference between the maximum and minimum token rates
# observed across the benchmark runs for each model.
# This metric indicates the consistency of performance - lower jitter suggests more stable results.

PROMPT="Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."
OUTPUT_FILE="benchmark_results.md"

# Ensure we have the list of models
ALL_MODELS=$(ls modelfiles/*Modelfile | sed 's|modelfiles/||;s/-Modelfile//')

# If models are passed as arguments, use those; otherwise, use all models
if [ $# -eq 0 ]; then
    MODELS="$ALL_MODELS"
else
    MODELS="$*"
fi

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
echo "| Model |" >> "$OUTPUT_FILE"
echo "| :--- |" >> "$OUTPUT_FILE"
for MODEL in $MODELS; do
    echo "| $MODEL |" >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

# Note on Jitter Calculation
echo "Jitter is calculated as the difference between the maximum and minimum token rates observed across the benchmark runs." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for MODEL in $MODELS; do
    echo "Running benchmark for model: $MODEL" >&2

    ollama run "$MODEL" "Say Hello" >/dev/null 2>&1
    
    # Add model header
    echo "### $MODEL" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"

    echo "#### Model Statistics" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Show running models with their details
    echo "\`\`\`" >> "$OUTPUT_FILE"
    ollama ps >> "$OUTPUT_FILE"
    echo "\`\`\`" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Create a temporary results file for this model
    TEMP_RESULTS="/tmp/benchmark_results_$MODEL.csv"
    rm -f "$TEMP_RESULTS"
    
    # Initialize variables for averaging
    total_ttft=0
    total_tokens_sec=0
    total_tokens=0
    total_prompt_rate=0
    run_count=0
    token_rates=()
    
    # Add table header for individual model runs
    echo "| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |" >> "$OUTPUT_FILE"
    echo "| :--- | :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"
    
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

        # Extract numeric value from token count for proper averaging
        EVAL_COUNT_NUM=$(echo "$EVAL_COUNT" | sed 's/ token(s)//' | sed 's/[^0-9.]//g')

        # Append to Markdown table
        printf "| %s | %s | %s | %s | %s |\n" "$RUN" "$TTFT" "$PROMPT_RATE" "$EVAL_RATE_VAL" "$EVAL_COUNT" >> "$OUTPUT_FILE"

        # Store results for averaging and jitter calculation
        if [[ ! -z "$PROMPT_EVAL_DURATION" ]]; then
            total_ttft=$(echo "$total_ttft + $TTFT" | bc -l 2>/dev/null)
            # Also accumulate prompt rate for average calculation
            if [[ "$PROMPT_RATE" != "N/A" ]] && [[ $PROMPT_RATE =~ ^[0-9]*\.?[0-9]+$ ]]; then
                total_prompt_rate=$(echo "$total_prompt_rate + $PROMPT_RATE" | bc -l 2>/dev/null)
            fi
            run_count=$((run_count + 1))
        fi
        
        # Only process token rates if they're valid numbers
        if [[ ! -z "$EVAL_COUNT" && ! -z "$EVAL_DURATION" ]]; then
            # Check if we have a valid eval rate value
            if [[ "$EVAL_RATE_VAL" != "N/A" ]] && [[ $EVAL_RATE_VAL =~ ^[0-9]*\.?[0-9]+$ ]]; then
                total_tokens_sec=$(echo "$total_tokens_sec + $EVAL_RATE_VAL" | bc -l 2>/dev/null)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT_NUM" | bc -l 2>/dev/null)
                token_rates+=("$EVAL_RATE_VAL")
            elif [[ "$TOKEN_RATE" != "N/A" ]] && [[ $TOKEN_RATE =~ ^[0-9]*\.?[0-9]+$ ]]; then
                # Use manual calculation if available
                total_tokens_sec=$(echo "$total_tokens_sec + $TOKEN_RATE" | bc -l 2>/dev/null)
                total_tokens=$(echo "$total_tokens + $EVAL_COUNT_NUM" | bc -l 2>/dev/null)
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
        avg_prompt_rate=$(echo "scale=2; $total_prompt_rate / $run_count" | bc -l 2>/dev/null)
        avg_tokens_sec=$(echo "scale=2; $total_tokens_sec / $run_count" | bc -l 2>/dev/null)
        avg_tokens=$(echo "scale=0; $total_tokens / $run_count" | bc -l 2>/dev/null)
        
        # If bc failed, set to N/A
        if [[ -z "$avg_ttft" ]]; then avg_ttft="N/A"; fi
        if [[ -z "$avg_prompt_rate" ]]; then avg_prompt_rate="N/A"; fi
        if [[ -z "$avg_tokens_sec" ]]; then avg_tokens_sec="N/A"; fi
        if [[ -z "$avg_tokens" ]]; then avg_tokens="N/A"; fi
        
        # Add average row to output file
        printf "| Average | %s | %s | %s | %s |\n" "$avg_ttft" "$avg_prompt_rate" "$avg_tokens_sec" "$avg_tokens" >> "$OUTPUT_FILE"
        
        # Calculate jitter (difference between max and min token rates)
        if [ ${#token_rates[@]} -ge 2 ]; then
            # Sort token rates
            IFS=$'\n' sorted_rates=($(sort -n <<<"${token_rates[*]}"))
            unset IFS
            
            # Get min and max values
            min_rate="${sorted_rates[0]}"
            max_rate="${sorted_rates[-1]}"
            
            # Calculate jitter
            jitter=$(echo "scale=2; $max_rate - $min_rate" | bc -l 2>/dev/null)
            
            # Add jitter information to the output
            echo "" >> "$OUTPUT_FILE"
            echo "#### Performance Metrics" >> "$OUTPUT_FILE"
            echo "| Metric | Value |" >> "$OUTPUT_FILE"
            echo "| :--- | :--- |" >> "$OUTPUT_FILE"
            echo "| Min Token Rate (tokens/s) | $min_rate |" >> "$OUTPUT_FILE"
            echo "| Max Token Rate (tokens/s) | $max_rate |" >> "$OUTPUT_FILE"
            echo "| Jitter (tokens/s) | $jitter |" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
        fi
    fi

    echo "" >> "$OUTPUT_FILE"
done