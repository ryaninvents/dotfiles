-- ---------------------------------
-- Set up `lazy.nvim` plugin manager
-- ---------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------
-- End `lazy.nvim` setup
-- ---------------------

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  'onsails/lspkind.nvim',
  'MunifTanjim/prettier.nvim',
  'nvim-treesitter/nvim-treesitter',
  'lewis6991/gitsigns.nvim',
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-tree/nvim-web-devicons',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  -- @see https://martinlwx.github.io/en/config-neovim-from-scratch/
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'lewis6991/gitsigns.nvim',
  'sindrets/diffview.nvim',
})

require('gitsigns').setup()
