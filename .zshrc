source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle knu/zsh-manydots-magic
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle Tarrasch/zsh-autoenv

# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


alias tsnow="date '+%Y%m%d.%H%M' | tr -d \"\n\r\""

# Set up personal links for local npm/Flutter/other bins
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

export EDITOR=vim
export GIT_EDITOR=vim

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey '^ ' forward-word