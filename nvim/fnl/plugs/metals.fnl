(module plugs.metals
  {autoload {a aniseed.core
            keys keys
            metals metals}})

(fn on-attach [client bufnr]
  (keys.lsp-setup bufnr))

(local capabilities (a.assoc-in (vim.lsp.protocol.make_client_capabilities)
                                [:textDocument :completion :completionItem :snippetSupport] true))
;; metals doesn't rely on nvim lspconfig so we need some special case for this file
(local cfg {:init_options {:statusBarProvider :on}
            :on_attach on-attach
            :capabilities capabilities
            :settings {:showImplicitArguments true
                       :showImplicitConversionsAndClasses true
                       :showInferredType true
                       ;; stack 8 and heap 8
                       :serverProperties ["-Xms8g" "-Xmx8g"]}})

(fn setup []
  (vim.opt_global.shortmess:remove :F)
  (metals.initialize_or_attach (a.merge metals.bare_config cfg)))

(setup)
;; setup will call via `metals-hook` since it need to require lua file and run so we add another indirection.
{:setup setup}
