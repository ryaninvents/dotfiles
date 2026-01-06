# Untheme

Untheme is a Neovim colorscheme that purposefully avoids hardcoded RGB colors and instead reuses your terminal emulator's palette exclusively. If you've already picked your favorite terminal theme, Untheme makes Neovim match it.

## Why
- No duplicated color decisions
- Works with any terminal preset (light or dark)
- Minimal highlight tweaks so terminal colors shine through
- Optional cterm-safe styling inspired by Alabaster

## Installation
This config already vendors Untheme locally (no external plugin needed):

- Logic: `lua/untheme/init.lua`
- Colorscheme entry: `colors/untheme.lua`
- LazyVim is set to use `untheme` via `lua/plugins/untheme.lua`

Neovim will apply Untheme at startup using the standard colorscheme entry.

## Usage
- Set the colorscheme:
  `:colorscheme untheme`
- Ensure terminal colors are used (Untheme sets this):
  `:set notermguicolors`

## Options
Untheme exposes optional sections you can enable/disable:
- Diagnostics: `Diagnostic*` underline/sign/virtual text
- Dialogs: floats, borders, popup menu, Telescope titles
- Treesitter: common `@` groups with cterm indices
- Code style: Alabaster-inspired mapping using only cterm indices

You can toggle these in the local loader `lua/plugins/untheme.lua` by passing flags:
```
require("untheme").apply({
  diagnostics = true,
  dialogs = true,
  treesitter = true,
})
```

Set any to `false` to skip them.

## Customization philosophy
Untheme avoids choosing literal RGB colors. It only applies safe attributes and common cterm indices so your terminal palette decides the look. The provided mappings aim to approximate Alabaster without hardcoding colors.

If you want to adjust a group:
```
:hi Visual term=reverse cterm=reverse
:hi DiagnosticUnderlineError term=undercurl cterm=undercurl
```

## Reloading during development
- Simple: `:colorscheme untheme`
- Module reload:
```
:lua package.loaded["untheme"] = nil
:colorscheme untheme
```
- Re-run the local loader by reloading Lazy:
```
:Lazy reload
```

### Optional: LazyVim hot reload helper
If you keep theme choice in a `plugins/theme.lua` spec, `lua/plugins/omarchy-theme-hotreload.lua` can reapply on `:Lazy reload`. With the current setup (`plugins/untheme.lua`) the built-in Lazy reload is sufficient.

## Notes
- Untheme sets `termguicolors` off to ensure cterm indices map to your terminal palette.
- Transparency or background tweaks from `plugin/after/transparency.lua` (if present) remain compatible.
