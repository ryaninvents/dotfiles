#!/bin/bash
echo 'Install Antigen...'
mkdir -p $HOME/.antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

echo 'Bootstrap dotfiles locally'
# Based on Atlassian bare repo method https://www.atlassian.com/git/tutorials/dotfiles

git init --bare --quiet $HOME/.cfg
# echo ".cfg" >> $HOME/.gitignore
config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
$config remote add origin "$(git config --get remote.origin.url)"
$config fetch origin
$config reset --hard origin/main
$config checkout main