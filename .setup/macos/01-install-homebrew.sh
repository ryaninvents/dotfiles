#!/bin/bash
set -euo pipefail

echo 'Installing Homebrew...'

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'Installed.'