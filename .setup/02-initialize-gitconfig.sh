#!/bin/bash
set -euo pipefail

if [ ! -f "$HOME/.gitconfig" ]; then
  cat > "$HOME/.gitconfig" <<EOF
[include]
    path = ./.gitconfig.preferences
EOF
fi
