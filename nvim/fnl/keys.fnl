
(local nvim (require :aniseed.nvim))

(fn nnoremap [key value]
  (nvim.set_keymap :n key value {:noremap true :silent true}))

(fn inoremap [key value]
  (nvim.set_keymap :i key value {:noremap true :silent true}))


(fn setup []
  ;; Tabs management
  (nnoremap :<leader>tn ":tabnew<cr>")
  (nnoremap :<leader>0 "10gt")
  (nnoremap :<leader>1 "1gt")
  (nnoremap :<leader>2 "2gt")
  (nnoremap :<leader>3 "3gt")
  (nnoremap :<leader>4 "4gt")
  (nnoremap :<leader>5 "5gt")
  (nnoremap :<leader>6 "6gt")
  (nnoremap :<leader>7 "7gt")
  (nnoremap :<leader>9 "8gt")
  (nnoremap :<leader>0 "10gt")

  ;; Buffers management
  (nnoremap :<leader>bn ":bnext<cr>")
  (nnoremap :<leader>bp ":bprevious<cr>")
  ;; <leader>bb for buffer list

  (nnoremap "]q" ":cn<cr>")
  (nnoremap "[q" ":cp<cr>")
  )


(fn lsp-setup [bufnr]
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
  (k :n :gr           "<cmd>lua vim.lsp.buf.references()<cr>" opts)
  (k :n :<leader>e     "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>" opts)
  (k :n "[d"          "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" opts)
  (k :n "]d"          "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" opts)
  (k :n :<leader>q     "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>" opts)
  (k :n :<leader>lf     "<cmd>lua vim.lsp.buf.formatting()<cr>" opts)

  ; Telescope
  (k :n :<leader>la ":lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>" opts)
  (k :v :<leader>la ":lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>" opts)
  (k :n :<leader>lw ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" opts)
  (k :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" opts)
  (k :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" opts))

{:setup setup :lsp-setup lsp-setup}

