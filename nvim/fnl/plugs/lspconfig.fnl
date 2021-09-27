(module plugs.lspconfig
  {autoload {nvim aniseed.nvim
            a aniseed.core
            lsp lspconfig
            cmplsp cmp_nvim_lsp
            keys keys
            rust-tools rust-tools}})

; Make it works thinking about proper place to puts this :p
; only mapping one to one from link for now will make it better after migrate to hotpot
;
; https://github.com/golang/tools/blob/master/gopls/doc/vim.md
(global goimports (fn [timeout_ms] 
  (local context {:only [:source.organizeImports]})
  (vim.validate {:context [context :t true]})

  (local params (vim.lsp.util.make_range_params))
  (tset params :context context)

  (let [result (vim.lsp.buf_request_sync 0 :textDocument/codeAction params timeout_ms)
        action (?. result 1 :result 1)

        exec (fn [action]
               (if action.edit                      (vim.lsp.util.apply_workspace_edit action.edit)
                 (= (type action.command) :table)   (vim.lsp.buf.execute_command action.command)
                 (vim.lsp.buf.execute_command action)))
        ]
    (-?> action exec))))

(vim.cmd "autocmd BufWritePre *.go lua goimports(1000)")

(fn on-attach [client bufnr] (keys.lsp-setup bufnr))

(local default-cfg {:on_attach on-attach
                    :capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :flags {:debounce-text-change 150}})


(local langs {:tsserver {:init_options {}}
              :clojure_lsp {}
              :ccls {:init_options {:clang {:extraArgs ["-std=c++20" "-lstdc++"]}}}
              :kotlin_language_server {}
              :gopls {}})
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
