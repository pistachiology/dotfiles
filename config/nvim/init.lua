
-- vim.lsp.set_log_level("off")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core')
require('keys').setup()
require('quick-command')


require('plugs.telescope')


--[[ require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = function(lang, bufnr)
            local disabled_list = {}
            for _, value in ipairs(disabled_list) do
                if value == lang then
                    return true
                end
            end
            return ts_disable(lang, bufnr)
        end,
        additional_vim_regex_highlighting = { "markdown" }
    }
} ]]

require('load-packers')


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

-- vim.cmd("set conceallevel=2")


require('nix.osc52')
require('nix.zk')
require('nix.venn')
require('nix.harpoon')

