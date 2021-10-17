
(local nvim (require :aniseed.nvim))

;; Generic Neovim configuration.
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)
(set nvim.o.number true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.completeopt "menu,menuone,noselect")
(set nvim.o.hidden true) ;; allows dirty buffer to be hidden instead of preventing to go to another buffer
(set nvim.g.qf_max_height 5)
(set nvim.o.tabstop 2)
(set nvim.o.shiftwidth 2)
(set nvim.o.softtabstop 2)
(set nvim.o.expandtab true)

(nvim.ex.set :invspell)
(nvim.ex.set :list)

;; Legacy Command
(vim.cmd "
lang en_US.utf-8
set encoding=utf-8
set fileencoding=utf-8
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
")


