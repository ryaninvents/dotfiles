-- colors/untheme.lua
-- Standard colorscheme entry that uses terminal palette only

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "untheme"
vim.opt.termguicolors = false

require("untheme").apply({
  diagnostics = true,
  dialogs = true,
  treesitter = true,
})
