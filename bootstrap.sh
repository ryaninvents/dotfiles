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

mkdir -p $HOME/.config-backup && \
	$config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
	xargs -I{} mv {} $HOME/.config-backup/{}
