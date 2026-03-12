local M = {}

local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

local function apply_core()
  vim.opt.termguicolors = false

  hi("Visual", { reverse = true })
  hi("Search", { reverse = true })
  hi("IncSearch", { reverse = true })

  hi("CursorLine", {})
  hi("CursorLineNr", {})

  hi("Normal", {})
  hi("NormalFloat", { ctermbg = 15 })
  hi("FloatBorder", { ctermbg = 15 })
  hi("Pmenu", { ctermbg = 15 })

  hi("WinSeparator", {})

  hi("Title", {})
  hi("Bold", { bold = true })
  hi("Italic", { italic = true })
  hi("Underlined", { underline = true })

  -- LSP document highlights: yellow background with blue text instead of reverse
  hi("LspReferenceText", { ctermfg = 0, ctermbg = 11 })
  hi("LspReferenceRead", { ctermfg = 0, ctermbg = 11 })
  hi("LspReferenceWrite", { ctermfg = 0, ctermbg = 11 })
end

function M.apply()
  apply_core()
end

return M
