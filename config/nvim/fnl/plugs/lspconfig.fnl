(local lsp (require :lspconfig))
(local cmplsp (require :cmp_nvim_lsp))
(local keys (require :keys))
(local rust-tools (require :rust-tools))
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
                                                           params timeout_ms)]
                      (each [cid res (pairs (or result {}))]
                        (each [_ r (pairs (or res.result {}))]
                          (if r.edit (let [enc (or (. (or (vim.lsp.get_client_by_id cid) {}) :offset_encoding) "utf-16")]
                                       (vim.lsp.util.apply_workspace_edit r.edit enc)))))
                      (vim.lsp.buf.format {:async false}))))

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
  ; (local eslint (node-lookup null-ls.builtins.diagnostics.eslint.with :eslint))
  ; (local eslint-format (node-lookup null-ls.builtins.formatting.eslint.with
  ;                                   :eslint))
  ; (local prettier (node-lookup null-ls.builtins.formatting.prettier.with
  ;                              :prettier))
  (null-ls.setup {:sources [(require :none-ls.code_actions.eslint_d)
                            (require :none-ls.formatting.eslint_d)
                            null-ls.builtins.formatting.isort
                            null-ls.builtins.formatting.black]}))

(null-ls-setup)

;; Defaults

(fn on-attach [client bufnr]
  (keys.lsp-setup bufnr))

(local default-cfg {:on_attach on-attach
                    :capabilities (cmplsp.default_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :flags {:debounce-text-change 150}})

(local langs {:ts_ls {:init_options {}
                         :on_attach (fn [client bufnr]
                                      (on-attach client bufnr)
                                      (tset client.server_capabilities
                                            :documentFormattingProvider false)
                                      (tset client.server_capabilities
                                            :documentRangeFormattingProvider false))}
              :clojure_lsp {}
              ; :ccls {:init_options {:clang {:extraArgs [:-std=c++20 :-lstdc++]}}}
              :clangd {:init_options {:clang {:extraArgs ["-std=c++20" "-stdlib=libc++"]}}
                       :capabilities {:offsetEncoding ["utf-16"]}
                       :cmd ["clangd" "--query-driver=/workplace/*/env/BrazilMuCmakeBuild-2.x/runtime/bin/x86_64-pc-linux-gnu-g++"]}
              :lua_ls {:settings {:Lua {:workspace {:maxPreload 4000
                                                    :library {(vim.fn.expand "$VIMRUNTIME/lua") true
                                                              (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}}}}}
              :kotlin_language_server {}
              :fennel_ls {:setings {:extra-globals "vim"}}
              :prismals {}
              :marksman {}
              :pyright {:init_options {:python {:analysis {:diagnosticSeverityOverrides {:strictParameterNoneValue false}
                                                           :diagnosticMode "off" 
                                                           :typeCheckingMode "off"}}}}
              :nixd {:settings {:nixd {:formatting {:command ["nixfmt"]}}}}
              :gopls {}})

(each [lang cfg (pairs langs)]
  (let [server (. lsp lang)
        setting (u.merge default-cfg cfg)]
    (server.setup setting)))

;; Rust
(let [rust-cfg {;;  https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                :server (u.merge default-cfg
                                 {:cmd (let [file (.. vim.env.HOME "/.toolbox/bin/rust-analyzer")]
                                             (if (u.nil? (vim.loop.fs_stat file)) nil file))
                                  :rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy
                                                                                           :allTargets false}
                                                                             :procMacro {:enable true}}}}})
                :tools {:autoSetHints true}}]
  (rust-tools.setup rust-cfg))
