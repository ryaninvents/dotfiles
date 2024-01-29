#!/bin/bash
set -euo pipefail

source "$HOME/._vars.sh"

echo 'Installing pnpm...'
npm install -g @pnpm/exe
echo 'Installed.'
