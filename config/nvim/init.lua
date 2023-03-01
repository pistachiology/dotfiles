require('impatient') -- must be first line

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core')
require('keys').setup()
require('quick-command')
require('load-packers')


require 'nvim-treesitter.configs'.setup {
    highlight = { enable = true, disable = { "fennel", "markdown" } }
}

local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'i',
    indicator_hint = '?',
    indicator_ok = 'Ok',
})

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' }, 
  { group = hocon_group, pattern = '*/resources/*.conf', command = 'set ft=hocon' }
)
