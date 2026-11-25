#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="$HOME/ollama-sycl-backups"
TARGET_DIR="/usr/local/lib/ollama/sycl"
TARGET_LIB="$TARGET_DIR/libggml-sycl.so"
BUILD_TMP="/tmp/ollama-sycl-build"
ONEAPI_ENV="/opt/intel/oneapi/setvars.sh"

mkdir -p "$BACKUP_DIR"

echo "=== 1. Checking current Ollama version & backing up existing SYCL library ==="
OLD_VER=$(ollama --version 2>/dev/null | awk '{print $NF}' || echo "none")
if [[ -f "$TARGET_LIB" ]]; then
    cp "$TARGET_LIB" "$BACKUP_DIR/libggml-sycl-${OLD_VER}.so.bak"
    echo "Backed up $TARGET_LIB -> $BACKUP_DIR/libggml-sycl-${OLD_VER}.so.bak"
fi

echo "=== 2. Running official Ollama installer ==="
curl -fsSL https://ollama.com/install.sh | sh
sleep 1

NEW_VER=$(ollama --version | awk '{print $NF}')
echo "Updated Ollama: $OLD_VER -> $NEW_VER"

sudo mkdir -p "$TARGET_DIR"

# If version didn't change and we have a backup, restore it directly without recompiling
if [[ "$OLD_VER" == "$NEW_VER" && -f "$BACKUP_DIR/libggml-sycl-${NEW_VER}.so.bak" ]]; then
    echo "=== 3. Ollama version unchanged ($NEW_VER); restoring cached SYCL library ==="
    sudo cp "$BACKUP_DIR/libggml-sycl-${NEW_VER}.so.bak" "$TARGET_LIB"
else
    echo "=== 3. Rebuilding libggml-sycl.so for Ollama v${NEW_VER} ==="
    rm -rf "$BUILD_TMP"
    git clone --depth 1 --branch "v${NEW_VER}" "https://github.com/ollama/ollama.git" "$BUILD_TMP"

    set +u
    source "$ONEAPI_ENV" --force
    set -u

    cmake -S "$BUILD_TMP/llama/server" -B "$BUILD_TMP/llama/server/build" \
        -DCMAKE_C_COMPILER=icx \
        -DCMAKE_CXX_COMPILER=icpx \
        -DMKL_DIR=/opt/intel/oneapi/mkl/latest/lib/cmake/mkl \
        -DGGML_SYCL=ON \
        -DGGML_SYCL_F16=ON \
        -DGGML_SYCL_DNN=OFF \
        -DGGML_BACKEND_DL=ON \
        -DGGML_BACKEND_SHARED=ON \
        -DGGML_NATIVE=OFF \
        -DCMAKE_BUILD_TYPE=Release

    cmake --build "$BUILD_TMP/llama/server/build" --target ggml-sycl -j "$(nproc)"

    BUILT_LIB=$(find "$BUILD_TMP/llama/server/build" -name "libggml-sycl.so" | head -n 1)
    if [[ -z "$BUILT_LIB" ]]; then
        echo "ERROR: libggml-sycl.so was not produced!"
        exit 1
    fi

    sudo cp "$BUILT_LIB" "$TARGET_LIB"
    cp "$BUILT_LIB" "$BACKUP_DIR/libggml-sycl-${NEW_VER}.so.bak"
    rm -rf "$BUILD_TMP"
    echo "Installed and backed up new library: $BACKUP_DIR/libggml-sycl-${NEW_VER}.so.bak"
fi

echo "=== 4. Ensuring permissions & restarting Ollama service ==="
sudo usermod -aG render,video ollama
sudo systemctl daemon-reload
sudo systemctl restart ollama

sleep 5
echo "=== 5. Verifying SYCL GPU detection ==="
journalctl -u ollama -n 20 --no-pager | grep -i -E "sycl|inference compute|version" || true
