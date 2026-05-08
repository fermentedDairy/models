#!/bin/bash

# Benchmark script for Ollama models
# Measures Time to First Token (TTFT) and Token Rate (tokens/sec)
# Saves results to a Markdown file

PROMPT="Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."
OUTPUT_FILE="benchmark_results.md"

# Ensure we have the list of models
MODELS=$(ls ollama/*Modelfile | sed 's|ollama/||;s/-Modelfile//')

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

echo "Starting benchmark... Saving results to $OUTPUT_FILE"

for RUN in 1 2 3; do
    echo "## Run $RUN" >> "$OUTPUT_FILE"
    echo "| Model | TTFT (s) | Tokens/sec | Total Tokens |" >> "$OUTPUT_FILE"
    echo "| :--- | :--- | :--- | :--- |" >> "$OUTPUT_FILE"

    for MODEL in $MODELS; do
        echo "Benchmarking $MODEL (Run $RUN)..."
        
        # Warmup call - this makes sure the model is running and loaded before running the benchmark task
        curl -s -X POST http://localhost:11434/api/generate -d "{
          \"model\": \"$MODEL\",
          \"prompt\": \"Say Hello\",
          \"stream\": false
        }" > /dev/null 2>&1

        # Run the prompt and capture metrics via Ollama API
        RESPONSE=$(curl -s -X POST http://localhost:11434/api/generate -d "{
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
        printf "| %s | %s | %s | %s |\n" "$MODEL" "$TTFT" "$TOKEN_RATE" "$EVAL_COUNT" >> "$OUTPUT_FILE"

        # Save raw response as pretty JSON in a benchmark folder named after the model and run
        mkdir -p "benchmark/$MODEL"
        echo "$RESPONSE" | jq . > "benchmark/$MODEL/response_run${RUN}.json"
    done
    echo "" >> "$OUTPUT_FILE"
done


echo "Benchmark complete."
