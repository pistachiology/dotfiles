(local telescope (require :telescope))
(local actions   (require :telescope.actions))
(local nvim      (require :aniseed.nvim))


(local opts {:noremap true})

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                             :path_display {:truncate 3}
                             :prompt_prefix "🔍 "
                             :mappings {:i {:<C-c> actions.delete_buffer}
                                        :n {:<C-c> actions.delete_buffer}}}
                  :pickers {:find_files {:find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}}
                  :extensions {:fzf {:fuzzy true
                                     :override_generic_sorter true
                                     :override_file_sorter true
                                     :case_mode :smart_case}}})
(telescope.load_extension :fzf)
(telescope.load_extension :frecency)

(nvim.set_keymap :n :<Leader>ff ":lua require('telescope.builtin').find_files()<cr>" opts)
(nvim.set_keymap :n :<Leader>fg ":lua require('telescope.builtin').live_grep()<cr>" opts)
(nvim.set_keymap :n :<Leader>fb ":lua require('telescope.builtin').buffers()<cr>" opts)
(nvim.set_keymap :n :<Leader>bb ":lua require('telescope.builtin').buffers()<cr>" opts)
(nvim.set_keymap :n :<leader>fc "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>" opts)

