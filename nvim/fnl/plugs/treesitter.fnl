
(local treesitter (require :nvim-treesitter.configs))

(treesitter.setup {:ensure_installed :maintained
                   :highlight {:enable true}
                   :indent {:enable true}
                   :incremental_selection {:enable true}})
