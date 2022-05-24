require('impatient') -- must be first line

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core')
require('keys').setup()
require('quick-command')
require('load-packers')


require'nvim-treesitter.configs'.setup {
    highlight = { enable = true, disable = {"fennel", "markdown"} }
}

