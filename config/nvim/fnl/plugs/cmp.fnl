(local cmp (require :cmp))

(fn setup []
  (cmp.setup {:enable true
              :snippet {:expand #(vim.fn.vsnip#anonymous $1.body)}
              :experimental {:ghost_text true}
              :completion {:completeopt "menu,menuone,noinsert"}
              :mapping (cmp.mapping.preset.insert {:<C-d> (cmp.mapping.scroll_docs -4)
                                                   :<C-f> (cmp.mapping.scroll_docs 4)
                                                   :<C-e> (cmp.mapping.close)
                                                   :<cr> (cmp.mapping.confirm {:select true})})
              :sources [{:name :buffer}
                        ; {:name :amazonq}
                        {:name :vsnip :priority 1338}
                        ; {:name :nvim_lsp :priority 1337}]}))
                        {:name :nvim_lsp :priority 1337}]}))

(setup)
