-- transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- white background (cterm 15) for dialogs and floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "FloatTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermbg = 15, reverse = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopeNormal", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { ctermbg = 15 })

-- command line area
vim.api.nvim_set_hl(0, "MsgArea", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "CmdLine", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "CmdLineIcon", { ctermbg = 15 })

-- autosuggestions / completion
vim.api.nvim_set_hl(0, "CmpNormal", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "CmpBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "CmpDocumentation", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { ctermbg = 15 })

-- transparent background for neotree
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

-- transparent background for nvim-tree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-- white background for notify dialogs
vim.api.nvim_set_hl(0, "NotifyINFOBody", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { ctermbg = 15 })

-- white background for lazygit
vim.api.nvim_set_hl(0, "LazyGitFloat", { ctermbg = 15 })
vim.api.nvim_set_hl(0, "LazyGitBorder", { ctermbg = 15 })
