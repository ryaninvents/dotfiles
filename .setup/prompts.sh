#!/bin/bash
set -euo pipefail

OS=$(uname)

if [ "$OS" == "Darwin" ]; then
    source "$(dirname "$0")/macos/prompts.sh"
fi
