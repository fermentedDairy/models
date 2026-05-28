#!/bin/bash

# Path to the models.json file
JSON_FILE="models.json"
# Target directory for models
MODELS_DIR="models"

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
  BASE_REPO=$(echo "$entry" | jq -r '."base-model".repo // empty')
  BASE_FILE=$(echo "$entry" | jq -r '."base-model".file // empty')
  ASSISTANT_REPO=$(echo "$entry" | jq -r '."assistant-model".repo // empty')
  ASSISTANT_FILE=$(echo "$entry" | jq -r '."assistant-model".file // empty')

  # Create a directory for the current model
  TARGET_DIR="$MODELS_DIR/$MODEL_NAME"
  mkdir -p "$TARGET_DIR"

  echo "Processing model: $MODEL_NAME"

  # Download base model
  if [[ -n "$BASE_REPO" ]]; then
    echo "  Downloading base model: $BASE_REPO ($BASE_FILE)"
    hf download "$BASE_REPO" "$BASE_FILE" --local-dir "$TARGET_DIR/base-model"
  fi

  # Download assistant model if it exists
  if [[ -n "$ASSISTANT_REPO" ]]; then
    echo "  Downloading assistant model: $ASSISTANT_REPO ($ASSISTANT_FILE)"
    hf download "$ASSISTANT_REPO" "$ASSISTANT_FILE" --local-dir "$TARGET_DIR/assistant-model"
  fi
done

echo "Download process completed."

