#!/bin/bash
set -euo pipefail

echo 'Bootstrapping dotfiles...'
# Based on Atlassian bare repo method https://www.atlassian.com/git/tutorials/dotfiles

git init --bare --quiet $HOME/.cfg
config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
$config remote add origin "$(git config --get remote.origin.url)"
$config fetch origin
$config reset --hard origin/main
$config checkout main

echo 'Bootstrapped.'