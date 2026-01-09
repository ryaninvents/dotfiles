source $HOME/.antigen/antigen.zsh

if [ -f ~/.private-vars ]; then
  source ~/.private-vars
fi

source ~/._vars.sh

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

alias gdh='git diff HEAD'

alias drpr='gh pr create --reviewer drplt/engineering'
alias drbr='git fetch && git comain '

alias cls=clear

alias confetti='open raycast://confetti'

alias y="yarn"
alias yw="yarn workspace"
alias ytho="yarn why"

alias p="pnpm"
alias pi="pnpm i"
alias pf="pnpm --filter"
alias pwhy="pnpm why"

alias oldvim="/usr/bin/vim"
alias vim="nvim"

alias :e="$EDITOR"

# Immediately execute !!, !$ without verifying
setopt no_hist_verify

# Set up personal links for local npm/Flutter/other bins
# export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH=/usr/local/bin:$PATH:$HOME/.local/bin:$HOME/bin
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"

export EDITOR="${EDITOR:-vim}"
export GIT_EDITOR="${GIT_EDITOR:-"$EDITOR"}"

export HIST_STAMPS="%Y%m%d.%H%M%S"

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey '^ ' forward-word


source <(npm completion)
PATH="/usr/local/bin:$PATH"
export DENO_INSTALL="/Users/ryan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

mkpatch () {
  local oldest_ancestor=$(git oldest-ancestor $1 $2)
  local patch_name=$(echo $1 | sed 's/\//_/g')
  git diff $oldest_ancestor..$1 > ../$patch_name.patch
}

pin () {
  echo "current git HEAD \`$(git rev-parse HEAD)\`" | pbcopy
}

ezpull () {
  node /Users/ryan/Projects/FOSS/ezpull/dist/index.js $@
}

export FZF_DEFAULT_OPTS='--height 40% --layout=default'

function list_all() {
    emulate -L zsh
    ls -a
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
test -e "/opt/homebrew/opt/fzf/shell/completion.zsh" && source "/opt/homebrew/opt/fzf/shell/completion.zsh"

export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="${HOME}/.pyenv/shims:${PATH}"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
mkdir -p "$PNPM_HOME"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

if which brew > /dev/null; then
  if [ -d "$(brew --prefix)/share/google-cloud-sdk" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  fi
fi

[ -s ~/.local/try.rb ] && eval "$(ruby ~/.local/try.rb init ~/Work/tries)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Added by Antigravity
export PATH="/Users/ryan/.antigravity/antigravity/bin:$PATH"

# opencode
[ -s ~/.opencode ] && export PATH=$HOME/.opencode/bin:$PATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# The next line enables shell command completion for nvm.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$HOME/.langflow/uv" ] && . "$HOME/.langflow/uv/env"

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd q edit-command-line


# bun completions
[ -s "/home/ryan/.bun/_bun" ] && source "/home/ryan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
