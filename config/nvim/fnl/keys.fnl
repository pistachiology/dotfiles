(local set_keymap vim.api.nvim_set_keymap)

(fn map [mode key value]
  (set_keymap mode key value {:noremap true :silent true}))

(fn nnoremap [key value]
  (set_keymap :n key value {:noremap true :silent true}))

(fn inoremap [key value]
  (set_keymap :i key value {:noremap true :silent true}))

(fn setup []
  ;; Tabs management
  (nnoremap :<leader>tn ":tabnew<cr>")
  (nnoremap :<leader>0 :10gt)
  (nnoremap :<leader>1 :1gt)
  (nnoremap :<leader>2 :2gt)
  (nnoremap :<leader>3 :3gt)
  (nnoremap :<leader>4 :4gt)
  (nnoremap :<leader>5 :5gt)
  (nnoremap :<leader>6 :6gt)
  (nnoremap :<leader>7 :7gt)
  (nnoremap :<leader>9 :8gt)
  (nnoremap :<leader>0 :10gt)
  ;; Buffers management
  (nnoremap :<leader>bn ":bnext<cr>")
  (nnoremap :<leader>bp ":bprevious<cr>")
  (nnoremap :<leader>cs "<cmd>lua quick_command_set()<cr>")
  (nnoremap :<leader>ce "<cmd>lua quick_command_execute()<cr>")
  (nnoremap :<leader>cc ":SlimeSend<cr>")
  (nnoremap "]q" ":cn<cr>")
  (nnoremap "[q" ":cp<cr>")
  (map :x :ga "<Plug>(EasyAlign)"))

(fn lsp-setup [bufnr]
  (local k #(vim.api.nvim_buf_set_keymap bufnr $...))
  (local o #(vim.api.nvim_buf_set_option bufnr $...))
  (o :omnifunc "v:lua.vim.lsp.omnifunc")
  (local opts {:noremap true :silent true})
  (k :n :gD "<cmd>lua vim.lsp.buf.declaration()<cr>" opts)
  (k :n :gd "<cmd>lua vim.lsp.buf.definition()<cr>" opts)
  (k :n :K "<cmd>lua vim.lsp.buf.hover()<cr>" opts)
  (k :n :gi "<cmd>lua vim.lsp.buf.implementation()<cr>" opts)
  (k :n :<C-k> "<cmd>lua vim.lsp.buf.signature_help()<cr>" opts)
  (k :n :<leader>wa "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>" opts)
  (k :n :<leader>wr "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>" opts)
  (k :n :<leader>wl
     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>"
     opts)
  (k :n :<leader>D "<cmd>lua vim.lsp.buf.type_definition()<cr>" opts)
  (k :n :<leader>rn "<cmd>lua vim.lsp.buf.rename()<cr>" opts)
  (k :n :gr "<cmd>lua vim.lsp.buf.references()<cr>" opts)
  (k :n :<leader>e "<cmd>lua vim.diagnostic.open_float({scope=\"line\"})<cr>" opts)
  (k :n "[d" "<cmd>lua vim.diagnostic.goto_prev()<cr>" opts)
  (k :n "]d" "<cmd>lua vim.diagnostic.goto_next()<cr>" opts)
  (k :n :<leader>q "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>" opts)
  (k :n :<leader>lf "<cmd>lua vim.lsp.buf.format({async = true})<cr>" opts) ; Telescope
  (k :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<cr>" opts)
  (k :v :<leader>la "<cmd>lua vim.lsp.buf.code_action()<cr>" opts)
  (k :n :<leader>lw
     ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" opts)
  (k :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>"
     opts)
  (k :n :<leader>li
     ":lua require('telescope.builtin').lsp_implementations()<cr>" opts)
  (k :n :<leader>ls
     ":lua require('telescope.builtin').lsp_document_symbols()<cr>" opts))

{: setup : lsp-setup}
