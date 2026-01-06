# Untheme

Untheme is a Neovim colorscheme that purposefully avoids hardcoded RGB colors and instead reuses your terminal emulator's palette exclusively. If you've already picked your favorite terminal theme, Untheme makes Neovim match it.

## Why
- No duplicated color decisions
- Works with any terminal preset (light or dark)
- Minimal highlight tweaks so terminal colors shine through

## Installation
This config already vendors Untheme locally (no external plugin needed):

- Colorscheme entry: `colors/untheme.lua`
- Minimal logic: `lua/untheme/init.lua`
- LazyVim is configured to use Untheme via `lua/plugins/untheme.lua`

If you're using LazyVim like this repo, nothing else is required. Neovim will pick `untheme` at startup.

## Usage
- Set the colorscheme at any time:
  `:colorscheme untheme`
- Ensure terminal colors are used (Untheme sets this):
  `:set notermguicolors`

## Customization philosophy
Untheme deliberately keeps highlight definitions sparse and avoids choosing specific foreground/background colors. It only applies safe attributes (reverse, bold, underline) so visibility is good across arbitrary palettes. Your terminal decides the actual colors.

If you want to adjust a group yourself, you can add Neovim highlight commands that stick to cterm attributes, for example:

```
:hi Visual term=reverse cterm=reverse
:hi Search term=reverse cterm=reverse
```

## Reloading during development
When you edit the theme files, you can reload without restarting Neovim.

### Option 1: Re-run the colorscheme (simple)
```
:colorscheme untheme
```

### Option 2: Manual module reload
```
:lua package.loaded["untheme"] = nil
:colorscheme untheme
```

### Option 3: Source the colors file directly
```
:source $MYVIMRC/../colors/untheme.lua
```

### Optional: LazyVim hot reload helper
If you also keep your theme choice in a `plugins/theme.lua` spec, the helper at `lua/plugins/omarchy-theme-hotreload.lua` can reapply on `:Lazy reload`. With the current setup (`plugins/untheme.lua`) use the options above instead.

## Notes
- Untheme sets `termguicolors` off to ensure cterm indices map to your terminal palette.
- Transparency or background tweaks from `plugin/after/transparency.lua` (if present) remain compatible.
