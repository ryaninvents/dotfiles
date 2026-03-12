# ~/.config/zsh/

Personal zsh configuration, sourced from `~/.zshrc`.

## Why the split?

`.zshrc` tends to accumulate tool-injected config (nvm, homebrew, pnpm, bun, etc.) mixed with personal settings. This makes it hard to maintain and leads to duplicates. The solution: `.zshrc` is reserved for auto-managed tool config only, and personal config lives here in modular files.

## Files

| File | Purpose |
|------|---------|
| `plugins.zsh` | Antigen / plugin manager setup — bundles, theme, apply |
| `aliases.zsh` | All aliases (git, editor, pnpm, yarn, timestamps, etc.) |
| `functions.zsh` | Custom shell functions (mkpatch, pin, yay, noisy, etc.) |
| `options.zsh` | Shell options, keybindings, env vars (EDITOR, vi mode, fzf) |
| `path.zsh` | Personal PATH additions (flutter, gems, local bins) |

## Adding new config

- **Personal config** → add to the appropriate file above
- **Tool-injected config** (e.g. `nvm`, `bun`, `pnpm`) → let the tool add it to `.zshrc`
