(local telescope (require :telescope))
(local actions   (require :telescope.actions))
(local nvim      (require :aniseed.nvim))

(local opts {:noremap true :silent true})

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                             :path_display {:truncate 3}
                             :layout_config {:horizontal {:width 0.95 :height 0.9 :preview_width 0.5}
                                             :vertical {:height 0.9 :preview_height: 0.5}}
                             ; :prompt_prefix "🔍 "
                             :mappings {:i {:<C-c> actions.delete_buffer}
                                        :n {:<C-c> actions.delete_buffer}}}
                  :pickers {:find_files {:find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}}
                  :extensions {:fzf {:fuzzy true
                                     :override_generic_sorter true
                                     :override_file_sorter true
                                     :case_mode :smart_case}}})
(telescope.load_extension :fzf)
(telescope.load_extension :frecency)

(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<cr>" opts)
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<cr>" opts)
(nvim.set_keymap :n :<leader>fs ":lua require('telescope.builtin').grep_string()<cr>" opts)
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<cr>" opts)
(nvim.set_keymap :n :<leader>fc "<cmd> require('telescope').extensions.frecency.frecency()<cr>" opts)

(nvim.set_keymap :n :<leader>bb ":lua require('telescope.builtin').buffers()<cr>" opts)
(nvim.set_keymap :n :<leader>bc ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" opts)

