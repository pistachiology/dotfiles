(module plugs.lspconfig
  {autoload {nvim aniseed.nvim
            a aniseed.core
            lsp lspconfig
            cmplsp cmp_nvim_lsp}})


(fn on-attach [client bufnr] 
  (local k #(nvim.buf_set_keymap bufnr $...))
  (local o #(nvim.buf_set_option bufnr $...))

  (o :omnifunc "v:lua.vim.lsp.omnifunc")

  (local opts {:noremap true :silent true})
  (k :n :gD           "<cmd>lua vim.lsp.buf.declaration()<cr>" opts)
  (k :n :gd           "<cmd>lua vim.lsp.buf.definition()<cr>" opts)
  (k :n :K            "<cmd>lua vim.lsp.buf.hover()<cr>" opts)
  (k :n :gi           "<cmd>lua vim.lsp.buf.implementation()<cr>" opts)
  (k :n :<C-k>        "<cmd>lua vim.lsp.buf.signature_help()<cr>" opts)
  (k :n :<leader>wa    "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>" opts)
  (k :n :<leader>wr    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>" opts)
  (k :n :<leader>wl    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>" opts)
  (k :n :<leader>D     "<cmd>lua vim.lsp.buf.type_definition()<cr>" opts)
  (k :n :<leader>rn    "<cmd>lua vim.lsp.buf.rename()<cr>" opts)
  (k :n :<leader>ca    "<cmd>lua vim.lsp.buf.code_action()<cr>" opts)
  (k :n :gr           "<cmd>lua vim.lsp.buf.references()<cr>" opts)
  (k :n :<leader>e     "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>" opts)
  (k :n "[d"          "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" opts)
  (k :n "]d"          "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" opts)
  (k :n :<leader>q     "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>" opts)
  (k :n :<leader>af     "<cmd>lua vim.lsp.buf.formatting()<cr>" opts)

  ; Telescope
  (k :n :<leader>ac ":lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>" opts)
  (k :v :<leader>la ":lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>" opts)
  (k :n :<leader>lw ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" opts)
  (k :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" opts)
  (k :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" opts)
  )

(local langs 
  {
   :rust_analyzer {:settings {:rust-analyzer {"checkOnSave" {:command "clippy" "allTargets" false}
                                               "procMacro" {:enable true}}}}
   })

(local default-cfg {:on_attach on-attach
                    :capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
                    :flags {:debounce-text-change 150}})

(each [lang cfg (pairs langs)]
  (let [server (. lsp lang)
        setting (a.merge default-cfg cfg)] 
    (server.setup setting)))

