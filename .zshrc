source $HOME/.antigen/antigen.zsh

if [ -f ~/.private-vars ]; then
  source ~/.private-vars
fi

# Needs to be above Antigen bundles so that `zsh-auto-nvm-use` can load correctly.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


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
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle Aloxaf/fzf-tab

antigen bundle Tarrasch/zsh-autoenv

# Auto-load the correct version of Node for the current dir
antigen bundle Sparragus/zsh-auto-nvm-use

# Load the theme.
antigen theme candy

# Tell Antigen that you're done.
antigen apply

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


alias tsnow="date '+%Y%m%d.%H%M' | tr -d \"\n\r\""
alias nowl="date '+%Y%m%d.%H%M%S' | tr -d \"\n\r\""
alias now="date -u '+%Y%m%d.%H%M%Sz' | tr -d \"\n\r\""
alias me="echo ryaninvents | tr -d \"\n\r\""
alias bb="echo \$(me)/\$(now) | tr -d \"\n\r\""

# Set up personal links for local npm/Flutter/other bins
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH=/usr/local/bin:$PATH:$HOME/.local/bin:$HOME/bin
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"

export EDITOR=vim
export GIT_EDITOR=vim

export HIST_STAMPS="%Y%m%d.%H%M%S"

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey '^ ' forward-word

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# The next line enables shell command completion for nvm.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# added by travis gem
[ ! -s /Users/ryan/.travis/travis.sh ] || source /Users/ryan/.travis/travis.sh

source <(npm completion)