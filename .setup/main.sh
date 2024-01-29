#!/bin/bash
set -euo pipefail

here="$(dirname "$0")"

# Use `source` here since we need the $CUSTOM_SOFTWARE variable
source "$here/prompts.sh"

"$here/01-bootstrap-dotfiles.sh"
"$here/02-initialize-gitconfig.sh"

"$here/11-install-antigen.sh"

"$here/99-platform-specific.sh"

