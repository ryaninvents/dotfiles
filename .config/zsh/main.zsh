# ============================================================================
# main.zsh — Entry point for personal zsh config
# ============================================================================
# This file controls the load order of all personal zsh configuration.
# Sourced from ~/.zshrc
# ============================================================================

# 1. Plugins (must load first for other configs to use)
source "${0:A:h}/plugins.zsh"

# 2. Shell options and environment
source "${0:A:h}/options.zsh"

# 3. PATH modifications
source "${0:A:h}/path.zsh"

# 4. Functions (before aliases so aliases can reference them)
source "${0:A:h}/functions.zsh"

# 5. Aliases (last, can reference everything else)
source "${0:A:h}/aliases.zsh"
