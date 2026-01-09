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
  hi("NormalFloat", {})

  hi("WinSeparator", {})

  hi("Title", {})
  hi("Bold", { bold = true })
  hi("Italic", { italic = true })
  hi("Underlined", { underline = true })
end

function M.apply()
  apply_core()
end

return M
