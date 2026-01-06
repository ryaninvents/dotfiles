local M = {}

-- Untheme: keep Neovim using the terminal palette only.
-- We avoid any GUI hex colors and rely on cterm attributes
-- so your terminal's preset colors decide the look.

local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

function M.apply()
  -- ensure we use terminal colors (cterm) not GUI hex
  vim.opt.termguicolors = false

  -- Minimal, safe tweaks that don't pick specific RGB colors
  -- and generally look OK across palettes. We intentionally
  -- keep Normal/StatusLine/etc. mostly to defaults.

  -- Use inverted colors for selections/search so they are always visible
  hi("Visual", { reverse = true })
  hi("Search", { reverse = true })
  hi("IncSearch", { reverse = true, bold = true })

  -- Keep cursorline subtle without forcing a color; many terminals do underline
  hi("CursorLine", {})
  hi("CursorLineNr", { bold = true })

  -- Keep Normal transparent to terminal background
  -- (no explicit fg/bg so terminal decides)
  hi("Normal", {})
  hi("NormalFloat", {})

  -- Window separators readable without choosing colors
  hi("WinSeparator", { bold = true })
end

return M
