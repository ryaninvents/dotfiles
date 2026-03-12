# Bare git repo for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Timestamps
alias tsnow="date '+%Y%m%d.%H%M' | tr -d \"\n\r\""
alias nowl="date '+%Y%m%d.%H%M%S' | tr -d \"\n\r\""
alias now="date -u '+%Y%m%d.%H%M%Sz' | tr -d \"\n\r\""
alias me="echo ryaninvents | tr -d \"\n\r\""
alias bb="echo \$(me)/\$(now) | tr -d \"\n\r\""

# Git
alias gdh='git diff HEAD'

# General
alias cls=clear
alias confetti='open raycast://confetti'

# Yarn
alias y="yarn"
alias yw="yarn workspace"
alias ytho="yarn why"

# pnpm
alias p="pnpm"
alias pi="pnpm i"
alias pf="pnpm --filter"
alias pwhy="pnpm why"

# Editor
alias oldvim="/usr/bin/vim"
alias vim="nvim"
alias :e="$EDITOR"
