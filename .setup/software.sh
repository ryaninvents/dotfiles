#!/bin/bash
set -euo pipefail

here="$(dirname "$0")"

source "$here/prompts.sh"

OS=$(uname)

if [ "$OS" == "Darwin" ]; then
    "$here/macos/software.sh"
fi
