(module plugs.lspconfig
  {autoload {nvim aniseed.nvim
            a aniseed.core
            lsp lspconfig
            cmplsp cmp_nvim_lsp
            keys keys
            rust-tools rust-tools}})


(fn on-attach [client bufnr] (keys.lsp-setup bufnr))

(local langs {})

(local default-cfg {:on_attach on-attach
                    :capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :flags {:debounce-text-change 150}})

(each [lang cfg (pairs langs)]
  (let [server (. lsp lang)
        setting (a.merge default-cfg cfg)] 
    (server.setup setting)))


;; Rust
(let [rust-cfg {
   ;;  https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
   :server (a.merge default-cfg {:rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command "clippy" :allTargets false}
                                                                            :procMacro {:enable true}}}}})
   :tools {:autoSetHints true}}]

  (rust-tools.setup rust-cfg)
  )
