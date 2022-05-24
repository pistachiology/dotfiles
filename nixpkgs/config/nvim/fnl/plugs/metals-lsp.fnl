(local lsp-signature (require :lsp_signature))
(local metals (require :metals))
(local keys (require :keys))

;; Copied from aniseed - to be clean up
(fn table? [x]
  (= "table" (type x)))

(fn count [xs]
  (if
    (table? xs) (let [maxn (table.maxn xs)]
                  ;; We only count the keys if maxn returns 0.
                  (if (= 0 maxn)
                    (table.maxn (keys xs))
                    maxn))
    (not xs) 0
    (length xs)))
(fn run! [f xs]
  "Execute the function (for side effects) for every xs."
  (when xs
    (let [nxs (count xs)]
      (when (> nxs 0)
        (for [i 1 nxs]
          (f (. xs i)))))))

(fn reduce [f init xs]
  "Reduce xs into a result by passing each subsequent value into the fn with
  the previous value as the first arg. Starting with init."
  (var result init)
  (run!
    (fn [x]
      (set result (f result x)))
    xs)
  result)
(fn merge! [base ...]
  (reduce
    (fn [acc m]
      (when m
        (each [k v (pairs m)]
          (tset acc k v)))
      acc)
    (or base {})
    [...]))

(fn merge [...]
  (merge! {} ...))


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
            :capabilities capabilities
            :settings {; :showImplicitArguments true
                       ; :showImplicitConversionsAndClasses true
                       ; :showInferredType true
                       ;; stack 8 and heap 8
                       :serverProperties ["-Xms8g" "-Xmx16g"]}})

(fn setup- []
  (vim.opt_global.shortmess:remove :F)
  (metals.initialize_or_attach (merge (metals.bare_config) cfg)))

(fn hook- []
  (local group (vim.api.nvim_create_augroup :lsp {}))

  (vim.api.nvim_create_autocmd "FileType" {:group group
                                           :pattern ["scala" "sbt"]
                                           :callback setup-})
  (vim.api.nvim_create_autocmd "FileType" {:group group
                                           :pattern ["scala"]
                                           :command "setlocal omnifunc=v:lua.vim.lsp.omnifunc"}))
(hook-)
