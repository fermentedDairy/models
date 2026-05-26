#!/bin/bash

# Check if required arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <model_name> <base_model_path> [quantization]"
  exit 1
fi

MODEL_NAME=$1
TARGET_BASE_DIR=$2
QUANTIZATION=${3:-"Q4_K_M"}

# Target directory for models
MODELS_DIR="models"
# Path to llama.cpp conversion script
CONVERT_SCRIPT="convert_hf_to_gguf.py"

# Ensure the models directory exists
mkdir -p "$MODELS_DIR"

# Check if conversion script is available
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is not installed."
    exit 1
fi

echo "Processing model: $MODEL_NAME"

if [[ -d "$TARGET_BASE_DIR" ]]; then
  echo "  Found base model at: $TARGET_BASE_DIR"
  
  # Output GGUF file name
  GGUF_OUTPUT="$MODELS_DIR/$MODEL_NAME.gguf"
  
  echo "  Converting to GGUF..."
  
  # Start conversion (F16)
  if python3 "$CONVERT_SCRIPT" "$TARGET_BASE_DIR" --outfile "$GGUF_OUTPUT" --outtype f16; then
      echo "  Quantizing to $QUANTIZATION..."
          # Assuming llama-quantize is available in PATH
          if llama-quantize "$GGUF_OUTPUT" "$GGUF_OUTPUT" "$QUANTIZATION"; then
              echo "  Successfully created $GGUF_OUTPUT ($QUANTIZATION)"
          else
              echo "  Error during quantization."
          fi
  else
      echo "  Error during conversion to GGUF."
  fi
else
  echo "  Skipping: $TARGET_BASE_DIR not found."
fi

echo "Conversion process completed."

