-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = ""

-- Disable relative line numbers
vim.opt.relativenumber = false

-- Highlight the line number of the current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Use bullet character for whitespace display
vim.opt.listchars = { tab = "> ", trail = "•", nbsp = "+" }
