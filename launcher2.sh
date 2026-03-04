#!/usr/bin/env bash

# ==============================================================================
# launcher2 - uv-based launcher for GM-TestFramework
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export UV_PROJECT_ENVIRONMENT="$SCRIPT_DIR/.venv"
export UV_CACHE_DIR="${UV_CACHE_DIR:-$SCRIPT_DIR/.uv/.uv_cache}"

_LAUNCHER_UV_VERSION="0.10.8"

# Check if uv is already available on PATH
if ! command -v uv &> /dev/null; then
    # uv not on PATH, check local install
    UV_INSTALL_DIR="$SCRIPT_DIR/.uv/bin"
    export PATH="$UV_INSTALL_DIR:$PATH"

    if ! command -v uv &> /dev/null; then
        # Install uv locally
        echo "uv not found, installing to \"$UV_INSTALL_DIR\"..."
        mkdir -p "$UV_INSTALL_DIR"

        if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
            # Windows (Git Bash)
            UV_ZIP="$UV_INSTALL_DIR/uv-windows.zip"

            if [[ "$PROCESSOR_ARCHITECTURE" == "ARM64" ]] || [[ "$(uname -m)" == "aarch64" ]]; then
                UV_ARCH="aarch64-pc-windows-msvc"
            else
                UV_ARCH="x86_64-pc-windows-msvc"
            fi

            curl -LsSf "https://github.com/astral-sh/uv/releases/download/$_LAUNCHER_UV_VERSION/uv-$UV_ARCH.zip" -o "$UV_ZIP" || {
                echo "Failed to download uv release."
                exit 1
            }
            unzip -q "$UV_ZIP" -d "$UV_INSTALL_DIR"
            rm -f "$UV_ZIP"
        else
            # macOS / Linux
            curl -LsSf https://astral.sh/uv/install.sh | env UV_UNMANAGED_INSTALL="$UV_INSTALL_DIR" UV_NO_MODIFY_PATH=1 sh || {
                echo "Failed to install uv."
                exit 1
            }
        fi

        chmod +x "$UV_INSTALL_DIR/uv" 2>/dev/null || true

        if [[ -x "$UV_INSTALL_DIR/uv" ]] || [[ -x "$UV_INSTALL_DIR/uv.exe" ]]; then
            echo "uv installed successfully."
        else
            echo "uv installation failed. Please install uv manually: https://docs.astral.sh/uv/getting-started/installation/"
            exit 1
        fi
    fi
fi

uv run python "$SCRIPT_DIR/launcher.py" "$@"
