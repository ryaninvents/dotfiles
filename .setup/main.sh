#!/bin/bash
set -euo pipefail

# Use `source` here since we need the $CUSTOM_SOFTWARE variable
source "$(dirname "$0")/prompts.sh"

"$(dirname "$0")/01-bootstrap-dotfiles.sh"

"$(dirname "$0")/11-install-antigen.sh"

"$(dirname "$0")/99-platform-specific.sh"

