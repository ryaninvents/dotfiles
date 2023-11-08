" @see https://vim.fandom.com/wiki/Example_vimrc
set nocompatible
filetype indent plugin on
syntax on

" Better command-line completion
set wildmenu

" Show partial commands
set showcmd

" Highlight searches
set hlsearch

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Enable use of the mouse for all modes
set mouse=a

" Show line numbers
set number

" Use two spaces for indent
set expandtab
set shiftwidth=2

let mapleader = ";"
