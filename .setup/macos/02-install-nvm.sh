#!/bin/bash
set -euo pipefail

echo 'Installing nvm...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo 'Setting up Node 20...'
nvm install 20
nvm alias default 20
echo 'Configuring ~/.npmrc...'
mkdir -p $HOME/.local/share/npm
npm config set prefix $HOME/.local/share/npm
echo 'Installed.'