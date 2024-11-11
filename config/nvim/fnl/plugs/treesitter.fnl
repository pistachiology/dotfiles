
(let [treesitter (require "nvim-treesitter.configs")
      ts_disable (fn [_ bufnr] (> (vim.api.nvim_buf_line_count bufnr) 5000))]

  (treesitter.setup {:highlight {:enable true
                                 :disable (fn [lang bufnr]
                                            (let [disabled_list {}]
                                              (each [_ value (ipairs disabled_list)]
                                                (when (= value lang) (lua "return true")))
                                              (ts_disable lang bufnr)))
                                 :additional_vim_regex_highlighting [:markdown]}
                     }))
