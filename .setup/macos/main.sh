#!/bin/bash

here="$(dirname "$0")"

"$here/01-install-homebrew.sh"
"$here/02-install-nvm.sh"

"$here/20-install-python.sh"
"$here/21-install-pnpm.sh"

"$here/31-software.sh"