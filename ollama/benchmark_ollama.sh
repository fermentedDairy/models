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

OLLAMA_HOST="${FD_OLLAMA_SERVER:-localhost}"
OLLAMA_URL="http://$OLLAMA_HOST:11434/api/generate"

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
    echo "| Run | TTFT (s) | Tokens/sec | Total Tokens |" >> "$OUTPUT_FILE"
    echo "| :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"
    
    # Initialize variables for averaging
    total_ttft=0
    total_tokens_sec=0
    total_tokens=0
    run_count=0
    
    for RUN in 1 2 3; do
        echo "" > "benchmark/responses_run${RUN}.txt"
        
        echo "Benchmarking $MODEL (Run $RUN)..."
        
        # Warmup call - this makes sure the model is running and loaded before running the benchmark task
        curl -s -X POST "$OLLAMA_URL" -d "{
          \"model\": \"$MODEL\",
          \"prompt\": \"Say Hello\",
          \"stream\": false
        }" > /dev/null 2>&1

        # Run the prompt and capture metrics via Ollama API
        RESPONSE=$(curl -s -X POST "$OLLAMA_URL" -d "{
          \"model\": \"$MODEL\",
          \"prompt\": \"$PROMPT\",
          \"stream\": false
        }")

        # Extract durations (in nanoseconds) and token count using jq
        PROMPT_EVAL_NS=$(echo "$RESPONSE" | jq -r '.prompt_eval_duration // 0')
        EVAL_NS=$(echo "$RESPONSE" | jq -r '.eval_duration // 0')
        EVAL_COUNT=$(echo "$RESPONSE" | jq -r '.eval_count // 0')

        # Convert nanoseconds to seconds and calculate metrics
        if [[ "$PROMPT_EVAL_NS" -gt 0 ]]; then
            TTFT=$(echo "scale=4; $PROMPT_EVAL_NS / 1000000000" | bc -l)
        else
            TTFT="N/A"
        fi

        if [[ "$EVAL_NS" -gt 0 && "$EVAL_COUNT" -gt 0 ]]; then
            TOKEN_RATE=$(echo "scale=2; $EVAL_COUNT / ($EVAL_NS / 1000000000)" | bc -l)
        else
            TOKEN_RATE="N/A"
        fi

        # Append to Markdown table
        printf "| %s | %s | %s | %s |\n" "$RUN" "$TTFT" "$TOKEN_RATE" "$EVAL_COUNT" >> "$OUTPUT_FILE"

        # Save raw response as pretty JSON in a benchmark folder named after the model and run
        mkdir -p "benchmark/$MODEL"
        echo "$RESPONSE" | jq . > "benchmark/$MODEL/response_run${RUN}.json"

        # Extract and format response to run-specific file
        echo "$MODEL" >> "benchmark/responses_run${RUN}.txt"
        echo "$RESPONSE" | jq -r '.response // empty' >> "benchmark/responses_run${RUN}.txt"
        echo "" >> "benchmark/responses_run${RUN}.txt"

        # Store results for averaging
        if [[ "$PROMPT_EVAL_NS" -gt 0 ]]; then
            total_ttft=$(echo "$total_ttft + $TTFT" | bc -l)
            run_count=$((run_count + 1))
        fi
        
        if [[ "$EVAL_NS" -gt 0 && "$EVAL_COUNT" -gt 0 ]]; then
            total_tokens_sec=$(echo "$total_tokens_sec + $TOKEN_RATE" | bc -l)
            total_tokens=$(echo "$total_tokens + $EVAL_COUNT" | bc -l)
        fi
        
        # Add to temporary results file for final average calculation
        echo "$MODEL,$RUN,$TTFT,$TOKEN_RATE,$EVAL_COUNT" >> "$TEMP_RESULTS"
    done
    
    # Calculate averages for this model
    if [ $run_count -gt 0 ]; then
        avg_ttft=$(echo "scale=4; $total_ttft / $run_count" | bc -l)
        avg_tokens_sec=$(echo "scale=2; $total_tokens_sec / $run_count" | bc -l)
        avg_tokens=$(echo "scale=0; $total_tokens / $run_count" | bc -l)
        
        # Add average row to output file
        printf "| Average | %s | %s | %s |\n" "$avg_ttft" "$avg_tokens_sec" "$avg_tokens" >> "$OUTPUT_FILE"
    fi
    
    echo "" >> "$OUTPUT_FILE"
done

# Calculate and display average results table at the end
echo "## Average Results" >> "$OUTPUT_FILE"
echo "| Model | Avg TTFT (s) | Avg Tokens/sec | Avg Total Tokens |" >> "$OUTPUT_FILE"
echo "| :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"

# Process the temporary results file to calculate averages by model
awk -F',' '
{
    model = $1
    ttft = $3
    tokens_sec = $4
    tokens = $5
    
    # Skip header line if it exists
    if (model != "Model") {
        if (ttft != "N/A") {
            total_ttft[model] += ttft
            count_ttft[model]++
        }
        if (tokens_sec != "N/A") {
            total_tokens_sec[model] += tokens_sec
            count_tokens_sec[model]++
        }
        total_tokens[model] += tokens
        count_tokens[model]++
    }
}
END {
    for (model in total_ttft) {
        avg_ttft = total_ttft[model] / count_ttft[model]
        avg_tokens_sec = total_tokens_sec[model] / count_tokens_sec[model]
        avg_tokens = total_tokens[model] / count_tokens[model]
        printf "| %s | %.4f | %.2f | %.0f |\n", model, avg_ttft, avg_tokens_sec, avg_tokens
    }
}' "$TEMP_RESULTS" >> "$OUTPUT_FILE"

# Clean up temporary file
rm "$TEMP_RESULTS"

echo "Benchmark complete."
