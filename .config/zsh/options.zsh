# Immediately execute !!, !$ without verifying
setopt no_hist_verify

export EDITOR="${EDITOR:-nvim}"
export GIT_EDITOR="${GIT_EDITOR:-"$EDITOR"}"
export HIST_STAMPS="%Y%m%d.%H%M%S"

autoload -U select-word-style
select-word-style shell

# Vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey '^ ' forward-word

# Edit command line in $EDITOR with 'q' in vicmd mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd q edit-command-line

export FZF_DEFAULT_OPTS='--height 40% --layout=default'
