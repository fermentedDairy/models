#!/bin/bash

# Path to the models.json file
JSON_FILE="models.json"
# Target directory for models
MODELS_DIR="models"
# Path to conversion script
CONVERT_SCRIPT="./convert_models.sh"

# Ensure the models directory exists
mkdir -p "$MODELS_DIR"

# Check if models.json exists
if [[ ! -f "$JSON_FILE" ]]; then
  echo "Error: $JSON/json not found."
  exit 1
fi

# Parse the JSON file and iterate through each model entry
jq -c '.[]' "$JSON_FILE" | while read -r entry; do
  MODEL_NAME=$(echo "$entry" | jq -r '."model-name"')
  BASE_MODEL=$(echo "$entry" | jq -r '."base-model"')
  ASSISTANT_MODEL=$(echo "$entry" | jq -r '."assistant-model"')
  QUANTIZATION=$(echo "$entry" | jq -r '.quantization // "Q4_K_M"')

  # Create a directory for the current model
  TARGET_DIR="$MODELS_DIR/$MODEL_NAME"
  mkdir -p "$TARGET_DIR"

  echo "Processing model: $MODEL_NAME"

  # Download base model
  if [[ "$BASE_MODEL" != "null" ]]; then
    echo "  Downloading base model: $BASE_MODEL"
    hf download "$BASE_MODEL" --local-dir "$TARGET_DIR/base-model"
    
    # Call conversion script after downloading base model
    bash "$CONVERT_SCRIPT" "$MODEL_NAME" "$TARGET_DIR/base-model" "$QUANTIZATION"
  fi

  # Download assistant model if it exists
  if [[ "$ASSISTANT_MODEL" != "null" ]]; then
    echo "  Downloading assistant model: $ASSISTANT_MODEL"
    hf download "$ASSISTANT_MODEL" --local-dir "$TARGET_DIR/assistant-model"

    # Call conversion script after downloading base model
    bash "$CONVERT_SCRIPT" "$MODEL_NAME-assistant" "$TARGET_DIR//assistant-model" "$QUANTIZATION"
  fi
done

echo "Download process completed."

