(local lsp-signature (require :lsp_signature))
(local metals (require :metals))
(local keys (require :keys))
(local u (require :utils))

(fn on-attach [client bufnr]
  (keys.lsp-setup bufnr)
  (metals.setup_dap)
  (lsp-signature.on_attach))

(local capabilities (vim.lsp.protocol.make_client_capabilities))
;; side-effect until we migrate util
(set capabilities.textDocument.completion.completionItem.snippetSupport true)

;; metals doesn't rely on nvim lspconfig so we need some special case for this file
(local cfg {:init_options {:statusBarProvider :on}
            :on_attach on-attach
            : capabilities
            :settings {; :showImplicitArguments true
                       ; :showImplicitConversionsAndClasses true
                       ; :showInferredType true
                       ;; stack 8 and heap 8
                       :serverProperties [:-Xms8g :-Xmx16g]}})

(fn setup- []
  (vim.opt_global.shortmess:remove :F)
  (metals.initialize_or_attach (u.merge (metals.bare_config) cfg)))

(fn hook- []
  (local group (vim.api.nvim_create_augroup :lsp {}))
  (vim.api.nvim_create_autocmd :FileType
                               {: group
                                :pattern [:scala :sbt]
                                :callback setup-})
  (vim.api.nvim_create_autocmd :FileType
                               {: group
                                :pattern [:scala]
                                :command "setlocal omnifunc=v:lua.vim.lsp.omnifunc"}))

(hook-)
