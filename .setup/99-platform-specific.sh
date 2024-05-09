#!/bin/bash
set -euo pipefail


here="$(dirname "$0")"
OS=$(uname)

if [ "$OS" == "Darwin" ]; then
    echo 'Installing MacOS-specific software...'
    "$here/macos/main.sh"
    echo 'Finished with MacOS'
elif [ "$OS" == "Linux" ]; then
    echo 'Installing Linux-specific software...'
    "$here/linux/main.sh"
    echo 'Finished with Linux'
else
    echo "Operating system '$OS' not recognized"
fi
