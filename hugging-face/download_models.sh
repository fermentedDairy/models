#!/bin/bash

# Path to the models.json file
JSON_FILE="models.json"
# Target directory for models
MODELS_DIR="models"

# Ensure the models directory exists
mkdir -p "$MODELS_DIR"

# Check if models.json exists
if [[ ! -f "$JSON_FILE" ]]; then
  echo "Error: $JSON_FILE not found."
  exit 1
fi

# Parse the JSON file and iterate through each model entry
# Using jq to extract model-name, base-model, and assistant-model
jq -c '.[]' "$JSON_FILE" | while read -r entry; do
  MODEL_NAME=$(echo "$entry" | jq -r '."model-name"')
  BASE_MODEL=$(echo "$entry" | jq -r '."base-model"')
  ASSISTANT_MODEL=$(echo "$entry" | jq -r '."assistant-model"')

  # Create a directory for the current model
  # We replace slashes in model names if they exist to avoid directory issues, 
  # but since these are identifiers, we use the model-name directly.
  TARGET_DIR="$MODELS_DIR/$MODEL_NAME"
  mkdir -p "$TARGET_DIR"

  echo "Processing model: $MODEL_NAME"

  # Download base model
  if [[ "$BASE_MODEL" != "null" ]]; then
    echo "  Downloading base model: $BASE_MODEL"
    hf download "$BASE_MODEL" --local-dir "$TARGET_DIR/base-model"
  fi

  # Download assistant model if it exists
  if [[ "$ASSISTANT_MODEL" != "null" ]]; then
    echo "  Downloading assistant model: $ASSISTANT_MODEL"
    hf download "$ASSISTANT_MODEL" --local-dir "$TARGET_DIR/assistant-model"
  fi
done

echo "Download process completed."
