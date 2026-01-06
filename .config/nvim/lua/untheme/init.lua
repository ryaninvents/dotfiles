local M = {}

-- Untheme code-highlighting philosophy
--
-- Goals:
-- - Only use terminal palette (cterm), never hex RGB.
-- - Keep weight normal for all code except comments.
-- - Comments are the sole bold element to improve readability across palettes.
-- - Simple, semantic color mapping using common cterm indices:
--     * Comments: magenta (5), bold
--     * Strings: green (2)
--     * Constants (numbers, booleans, keywords): yellow (3)
--     * Definitions (functions, declared identifiers): blue (4)
--     * Everything else: default terminal foreground
-- - Avoid over-styling; let the terminal theme define the feel.

local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

local function apply_core()
  -- use terminal colors (cterm), not GUI hex
  vim.opt.termguicolors = false

  -- selections & search remain highly visible without choosing colors
  hi("Visual", { reverse = true })
  hi("Search", { reverse = true })
  hi("IncSearch", { reverse = true })

  -- cursor line
  hi("CursorLine", {})
  hi("CursorLineNr", {})

  -- respect terminal bg/fg
  hi("Normal", {})
  hi("NormalFloat", {})

  -- separators
  hi("WinSeparator", {})

  -- generic UI states
  hi("Title", {})
  hi("Bold", { bold = true })
  hi("Italic", { italic = true })
  hi("Underlined", { underline = true })
end

local function apply_code()
  -- Comments: bold magenta
  hi("Comment", { ctermfg = 5, bold = true })

  -- Strings: green
  hi("String", { ctermfg = 2 })
  hi("Character", { ctermfg = 2 })

  -- Constants: yellow
  hi("Constant", { ctermfg = 3 })
  hi("Number", { ctermfg = 3 })
  hi("Boolean", { ctermfg = 3 })

  -- Definitions: blue (functions and declared identifiers)
  hi("Function", { ctermfg = 4, bold = true })
  hi("Identifier", { ctermfg = 4, bold = true })

  -- Everything else defaults; avoid extra styling
  hi("Operator", {})
  hi("Delimiter", {})
  hi("PreProc", {})
  hi("Special", {})
  hi("Type", {})
  hi("StorageClass", {})
  hi("Keyword", {})
  hi("Statement", {})
end

local function apply_diagnostics()
  -- keep underline/undercurl for clarity; color indices only
  hi("DiagnosticError", { ctermfg = 1, underline = true })
  hi("DiagnosticWarn", { ctermfg = 3, underline = true })
  hi("DiagnosticInfo", { ctermfg = 4 })
  hi("DiagnosticHint", { ctermfg = 6, underline = true })

  hi("DiagnosticUnderlineError", { undercurl = true })
  hi("DiagnosticUnderlineWarn", { undercurl = true })
  hi("DiagnosticUnderlineInfo", { undercurl = true })
  hi("DiagnosticUnderlineHint", { undercurl = true })

  hi("DiagnosticVirtualTextError", { ctermfg = 1 })
  hi("DiagnosticVirtualTextWarn", { ctermfg = 3 })
  hi("DiagnosticVirtualTextInfo", { ctermfg = 4 })
  hi("DiagnosticVirtualTextHint", { ctermfg = 6 })

  hi("DiagnosticSignError", { ctermfg = 1 })
  hi("DiagnosticSignWarn", { ctermfg = 3 })
  hi("DiagnosticSignInfo", { ctermfg = 4 })
  hi("DiagnosticSignHint", { ctermfg = 6 })
end

local function apply_dialogs()
  -- avoid bold/underline in general UI to keep code emphasis on comments
  hi("FloatBorder", {})
  hi("FloatTitle", {})

  hi("Pmenu", {})
  hi("PmenuSel", { reverse = true })
  hi("PmenuSbar", {})
  hi("PmenuThumb", { reverse = true })

  hi("TelescopeTitle", {})
  hi("TelescopeBorder", {})

  -- Snacks Explorer icons: ensure no underline
  hi("SnacksExplorerIcon", { underline = false })
  hi("SnacksExplorerGitIcon", { underline = false })
  hi("SnacksExplorerFileIcon", { underline = false })
end

local function apply_treesitter()
  -- Map TS groups to the same philosophy
  -- Definitions
  hi("@function", { ctermfg = 4, bold = true })
  hi("@method", { ctermfg = 4, bold = true })
  hi("@parameter", {})
  hi("@variable", {})
  hi("@field", {})
  hi("@property", {})

  -- Constants
  hi("@constant", { ctermfg = 3 })
  hi("@number", { ctermfg = 3 })
  hi("@boolean", { ctermfg = 3 })

  -- Strings
  hi("@string", { ctermfg = 2 })
  hi("@character", { ctermfg = 2 })

  -- Types and namespaces default
  hi("@type", {})
  hi("@type.builtin", {})
  hi("@namespace", {})

  -- Punctuation/operators default
  hi("@operator", {})
  hi("@punctuation", {})
  hi("@keyword", {})
  hi("@keyword.function", {})

  -- Comments: bold magenta
  hi("@comment", { ctermfg = 5, bold = true })
end

function M.apply(opts)
  opts = opts or {}
  apply_core()
  apply_code()
  if opts.diagnostics ~= false then apply_diagnostics() end
  if opts.dialogs ~= false then apply_dialogs() end
  if opts.treesitter ~= false then apply_treesitter() end
end

return M
