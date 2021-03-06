" Project Specific .vimrc Files
set exrc
set nocompatible
set t_Co=256

hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Basic Configuration
filetype on
syntax on
set number

" colorscheme one
set laststatus=2 " Hide airline

let mapleader = " "

" set vim encoding
set encoding=utf-8
set fileencoding=utf-8
" set termencoding=utf-8
lang en_US.utf-8

filetype plugin on
filetype indent on
filetype plugin indent on

set completeopt+=noselect


" auto indent
set autoindent

" scroll speed
set scroll=16

" allow backspacing over autoindent, linebreaks and starting point
set backspace=indent,eol,start

" set tab stops
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
" COMMAND to use old-style tab
command Tab setl shiftwidth=4 tabstop=4 softtabstop=0 noexpandtab indentexpr=

  
" other stuff
" searching: incremental, highlight, smart case
set incsearch hlsearch smartcase

" gui font
set guifont="PragmataPro Mono Liga":h14


" show line number and command being entered
set showcmd number


" COMMAND to setup autocommands
command -nargs=* Auto au BufNewFile,BufRead <args>
command -nargs=* AutoType au FileType <args>
" resize if windows is resized
autocmd VimResized * wincmd =

" COMMAND to fix typing mistakes
command Q q
command Wq wq
command WQ wq

"enable mouse
set mouse=a

"
set ignorecase
set smartcase

" relative line number
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Terminal mode
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>l <C-\><C-n><C-w>l

" NNN
let g:nnn#set_default_mappings = 0
let g:nnn#session = 'local'
" Opens the n³ window in a split
let g:nnn#layout = 'new' " or vnew, tabnew etc.
" Or pass a dictionary with window size
let g:nnn#layout = { 'left': '~21%' } " or right, up, down
" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }



source ~/.config/nvim/plugin.vim
source ~/.config/nvim/theme.vim
source ~/.config/nvim/priv.vim
source ~/.config/nvim/config.vim
source ~/.config/nvim/custom_command.vim
source ~/.config/nvim/conceals.vim
source ~/.config/nvim/coc.vim
" source ~/.config/nvim/language_client.vim



