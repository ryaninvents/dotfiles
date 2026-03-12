# ============================================================================
# .zshrc — AUTO-MANAGED ONLY
# ============================================================================
# This file is reserved for config auto-added by tools (nvm, homebrew, pnpm,
# bun, etc.). Do not add personal config here.
#
# Personal shell config lives in:  ~/.config/zsh/
#   plugins.zsh   — Antigen / plugin manager setup
#   aliases.zsh   — Aliases
#   functions.zsh — Custom shell functions
#   options.zsh   — Shell options, keybindings, env vars
#   path.zsh      — Personal PATH additions
#
# See ~/.config/zsh/README.md for details.
# ============================================================================

# Source personal config
for f in ~/.config/zsh/*.zsh; do
  source "$f"
done

# Private vars (API keys, tokens, etc.)
if [ -f ~/.private-vars ]; then
  source ~/.private-vars
fi

# Homebrew
[ -s "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
mkdir -p "$PNPM_HOME"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/ryan/.bun/_bun" ] && source "/home/ryan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# deno
export DENO_INSTALL="/Users/ryan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# pyenv
export PATH="${HOME}/.pyenv/shims:${PATH}"

# Google Cloud SDK
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf keybindings and completion
test -e "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
test -e "/opt/homebrew/opt/fzf/shell/completion.zsh" && source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# npm completion
source <(npm completion)

# Antigravity
export PATH="/Users/ryan/.antigravity/antigravity/bin:$PATH"

# opencode
[ -s ~/.opencode ] && export PATH=$HOME/.opencode/bin:$PATH

# langflow
[ -s "$HOME/.langflow/uv" ] && . "$HOME/.langflow/uv/env"

# try.rb
[ -s ~/.local/try.rb ] && eval "$(ruby ~/.local/try.rb init ~/Work/tries)"
