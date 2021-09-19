(module plugs.cmp
  {require {nvim aniseed.nvim
            cmp cmp}})

(defn setup []
  (cmp.setup {:enable true
              :completion {:completeopt "menu,menuone,noinsert"}
              :mapping {:<C-d> (cmp.mapping.scroll_docs -4)
                        :<C-f> (cmp.mapping.scroll_docs 4)
                        :<C-e> (cmp.mapping.close)
                        :<cr>  (cmp.mapping.confirm {:select true})}
              :sources [{:name "buffer"}
                        {:name "conjure"}
                        {:name "nvim_lsp"}]}))

(setup)
