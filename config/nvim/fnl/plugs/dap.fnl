(local set_keymap vim.api.nvim_set_keymap)

(fn map [mode key value]
  (set_keymap mode key value {:noremap true :silent true}))

(fn nnoremap [key value]
  (set_keymap :n key value {:noremap true :silent true}))

(fn inoremap [key value]
  (set_keymap :i key value {:noremap true :silent true}))

(global dap_ui_widgets_frames (fn []
                                (local widgets (require :dap.ui.widgets))
                                (local bar (widgets.sidebar widgets.frames))
                                (bar.open)))

(global dap_ui_widgets_scopes (fn []
                                (local widgets (require :dap.ui.widgets))
                                (local bar (widgets.sidebar widgets.scopes))
                                (bar.open)))

(fn setup []
  (nnoremap :<leader>dc "<cmd>lua require'dap'.continue()<CR>")
  (nnoremap :<leader>dl "<cmd>lua require'dap'.run_last()<CR>")
  (nnoremap :<leader>dr "<cmd>lua require'dap'.repl.toggle()<CR>")
  (nnoremap :<leader>dv "<cmd>lua require'dap.ui.variables'.scopes()<CR>")
  (nnoremap :<leader>dbt "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
  (nnoremap :<leader>dso "<cmd>lua require'dap'.step_over()<CR>")
  (nnoremap :<leader>dst "<cmd>lua require'dap'.step_out()<CR>")
  (nnoremap :<leader>dsi "<cmd>lua require'dap'.step_into()<CR>")
  (nnoremap :<leader>dK "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
  (nnoremap :<leader>dwf "<cmd>lua dap_ui_widgets_frames()<CR>")
  (nnoremap :<leader>dws "<cmd>lua dap_ui_widgets_scopes()<CR>")
  (local dap (require :dap))
  (tset dap.configurations :scala
        [{:type :scala
          :request :launch
          :name "Run"
          :metals {:runType :run :jvmOptions [:-Xms8g :-Xmx16g]}}
         {:type :scala
          :request :launch
          :name "Test Target"
          :metals {:runType :testTarget :jvmOptions [:-Xms8g :-Xmx16g]}}]))

(setup)
