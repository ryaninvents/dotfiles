#!/bin/bash
set -euo pipefail

echo 'Installing Antigen...'
mkdir -p $HOME/.antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
echo 'Installed.'