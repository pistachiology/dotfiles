;; Generic Neovim configuration.
(set vim.o.termguicolors true)
(set vim.o.mouse :a)
(set vim.o.updatetime 500)
(set vim.o.timeoutlen 500)
(set vim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set vim.o.inccommand :split)
(set vim.o.number true)
(set vim.o.ignorecase true)
(set vim.o.smartcase true)
(set vim.o.completeopt "menu,menuone,noselect")
(set vim.o.hidden true)

;; allows dirty buffer to be hidden instead of preventing to go to another buffer
(set vim.g.qf_max_height 5)
(set vim.o.tabstop 2)
(set vim.o.shiftwidth 2)
(set vim.o.softtabstop 2)
(set vim.o.expandtab true)

;; Legacy Command
; lang en_US.utf-8
(vim.cmd "
set encoding=utf-8
set fileencoding=utf-8
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set number relativenumber
set list
set invspell

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
")
