#!/bin/bash

echo "--- Starting Ollama Model Creation ---"

OLLAMA_DIR="./modelfiles"

# 2. Loop through all files in the ollama directory that end with -Modelfile
for modelfile in ${OLLAMA_DIR}/*-Modelfile; do
    # Extract the base model name from the filename (e.g., "fd-gemma4-e4b-Modelfile" -> "fd-gemma4-e4b")
    model_name=$(basename "$modelfile" "-Modelfile")
    
    echo "Attempting to create model '$model_name' using the file: $modelfile"
    
    # 3. Run ollama create command
    ollama create "$model_name" -f "$modelfile"
    
    if [ $? -eq 0 ]; then
        echo "Successfully created/verified model: $model_name"
    else
        echo "Failed to create model: $model_name. Check if 'ollama' tool is installed and configured."
    fi
done

echo "--- Model creation process complete ---"