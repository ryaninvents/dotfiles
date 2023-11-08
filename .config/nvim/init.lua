vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath=&runtimepath
  source ~/.vimrc
]])


require('options')
require('plugins')
require('lsp')
require('keymaps')
