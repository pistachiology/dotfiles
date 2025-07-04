(local telescope (require :telescope))
(local actions (require :telescope.actions))
(local builtin (require :telescope.builtin))

(local set_keymap vim.api.nvim_set_keymap)

(local opts {:noremap true :silent true})

(telescope.setup {:defaults {:file_ignore_patterns [:node_modules]
                             :preview {:treesitter false}
                             ; this cause neovim to hang sometimes. https://github.com/nvim-telescope/telescope.nvim/issues/1379
                             :path_display {:truncate 3}
                             :layout_config {:horizontal {:width 0.95
                                                          :height 0.9
                                                          :preview_width 0.5}
                                             :vertical {:height 0.9
                                                        "preview_height:" 0.5}}
                             ; :prompt_prefix "🔍 "
                             :mappings {:i {:<C-c> actions.delete_buffer
                                            :<C-q> (+ actions.send_selected_to_qflist actions.open_qflist)
                                            :<C-Q> (+ actions.send_to_qflist actions.open_qflist)}
                                        :n {:<C-c> actions.delete_buffer
                                            :<C-q> (+ actions.send_selected_to_qflist actions.open_qflist)
                                            :<C-Q> (+ actions.send_to_qflist actions.open_qflist)}}}

                  :pickers {:find_files {:find_command [:rg
                                                        :--files
                                                        :--iglob
                                                        :!.git
                                                        :--hidden]}}
                  :extensions {:fzf {:fuzzy true
                                     :override_generic_sorter true
                                     :override_file_sorter true
                                     :case_mode :smart_case}}
                  :ui-select [((. (require :telescope.themes) :get_dropdown))]})

(telescope.load_extension :fzf)
(telescope.load_extension :frecency)
(telescope.load_extension :ui-select)

(global telescope_live_grep
        (fn []
          (builtin.live_grep {:debounce 200})))

(set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<cr>"
            opts)

(set_keymap :n :<leader>fg ":lua telescope_live_grep()<cr>" opts)
(set_keymap :n :<leader>fc
            ":lua require('telescope.builtin').grep_string()<cr>" opts)

(set_keymap :n :<leader>fs
            ":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep for > \") })<cr>"
            opts)

(set_keymap :n :<leader>fq ":lua require('telescope.builtin').quickfix()<cr>"
            opts)

(set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<cr>"
            opts)

(set_keymap :n :<leader>bb ":lua require('telescope.builtin').buffers()<cr>"
            opts)

(set_keymap :n :<leader>bc
            ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"
            opts)
