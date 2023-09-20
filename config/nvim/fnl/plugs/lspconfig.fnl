(local lsp (require :lspconfig))
(local cmplsp (require :cmp_nvim_lsp))
(local keys (require :keys))
(local rust-tools (require :rust-tools))
(local null-ls (require :null-ls))
(local u (require :utils))

;; Golang
; Make it works thinking about proper place to puts this :p
; only mapping one to one from link for now will make it better after migrate to hotpot
;
; https://github.com/golang/tools/blob/master/gopls/doc/vim.md
(global goimports (fn [timeout_ms]
                    (local context {:only [:source.organizeImports]})
                    (vim.validate {:context [context :t true]})
                    (local params (vim.lsp.util.make_range_params))
                    (tset params :context context)
                    (let [result (vim.lsp.buf_request_sync 0
                                                           :textDocument/codeAction
                                                           params timeout_ms)
                          action (?. result 1 :result 1)
                          exec (fn [action]
                                 (if action.edit
                                     (vim.lsp.util.apply_workspace_edit action.edit)
                                     (= (type action.command) :table)
                                     (vim.lsp.buf.execute_command action.command)
                                     (vim.lsp.buf.execute_command action)))]
                      (-?> action exec))))

(vim.api.nvim_create_autocmd :BufWritePre
                             {:pattern [:*.go]
                              :callback (fn []
                                          (goimports 1000))})

;; Null-ls
(fn null-ls-setup []
  (local null-ls (require :null-ls))
  (local helper (require :null-ls.helpers))
  (local node-lookup (fn [mod bin]
                       (let [project-local-bin (.. :node_modules/.bin/ bin)
                             cfg {:prefer_local project-local-bin :command bin}]
                         (mod cfg))))
  (local eslint (node-lookup null-ls.builtins.diagnostics.eslint.with :eslint))
  (local eslint-format (node-lookup null-ls.builtins.formatting.eslint.with
                                    :eslint))
  (local prettier (node-lookup null-ls.builtins.formatting.prettier.with
                               :prettier))
  (null-ls.setup {:sources [prettier eslint eslint-format]}))

(null-ls-setup)

;; Defaults

(fn on-attach [client bufnr]
  (keys.lsp-setup bufnr))

(local default-cfg {:on_attach on-attach
                    :capabilities (cmplsp.default_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :flags {:debounce-text-change 150}})

(local langs {:tsserver {:init_options {}
                         :on_attach (fn [client bufnr]
                                      (on-attach client bufnr)
                                      (tset client.server_capabilities
                                            :documentFormattingProvider false)
                                      (tset client.server_capabilities
                                            :documentRangeFormattingProvider false))}
              :clojure_lsp {}
              ; :ccls {:init_options {:clang {:extraArgs [:-std=c++20 :-lstdc++]}}}
              :clangd {:init_options {:clang {:extraArgs ["-std=c++20" "-stdlib=libc++"]}}}
              :lua_ls {:settings {:Lua {:workspace {:maxPreload 4000
                                                    :library {(vim.fn.expand "$VIMRUNTIME/lua") true
                                                              (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}}}}}
              :kotlin_language_server {}
              :prismals {}
              :rnix {}
              :marksman {}
              :pyright {:init_options {:python {:analysis {:diagnosticSeverityOverrides {:strictParameterNoneValue false}
                                                           :diagnosticMode "off" 
                                                           :typeCheckingMode "off"}}}}
              :gopls {}})

(each [lang cfg (pairs langs)]
  (let [server (. lsp lang)
        setting (u.merge default-cfg cfg)]
    (server.setup setting)))

;; Rust
(let [rust-cfg {;;  https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                :server (u.merge default-cfg
                                 {:rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy
                                                                                           :allTargets false}
                                                                             :procMacro {:enable true}}}}})
                :tools {:autoSetHints true}}]
  (rust-tools.setup rust-cfg))
