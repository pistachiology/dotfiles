(local gitlinker (require :gitlinker))

(let 
   [callbacks {}]
   (gitlinker.setup {: opts : callbacks}))

(global custom_gitlinks_yank_n 
  (fn []
    (let [action_callback (fn [url]
                            ;; patch url since vim treat # as a special character
                            (vim.api.nvim_exec (.. "!echo '" (url:gsub "#" "\\#") "' | base64 | ssh laptop 'base64 -d | pbcopy'") {}))]
      (gitlinker.get_buf_range_url "n" {: action_callback}))))

(global custom_gitlinks_yank_v
  (fn []
    (let [action_callback (fn [url]
                            ;; patch url since vim treat # as a special character
                            (vim.api.nvim_exec (.. "!echo '" (url:gsub "#" "\\#") "' | base64 | ssh laptop 'base64 -d | pbcopy'") {}))]
      (gitlinker.get_buf_range_url "v" {: action_callback}))))

; (global custom_gitlinks_open_in_browser_n 
;   (fn []
;     (let [action_callback (fn [url]
;                             ;; patch url since vim treat # as a special character
; not working :'(
;                             (vim.api.nvim_exec (.. "!ssh laptop open -a /Applications/Google\\ Chrome.app '" (url:gsub "#" "\\#") "'") {}))]
;       (gitlinker.get_buf_range_url "n" {: action_callback}))))

; (global custom_gitlinks_open_in_browser_v
;   (fn []
;     (let [action_callback (fn [url]
;                             ;; patch url since vim treat # as a special character
;                             (vim.api.nvim_exec (.. "!ssh laptop open -a '/Applications/Google\\ Chrome.app' '" "https://google.com" "'") {}))]
;       (gitlinker.get_buf_range_url "v" {: action_callback}))))

(vim.api.nvim_set_keymap "n" "<leader>gy"  "<cmd>lua custom_gitlinks_yank_n()<cr>" {:silent true})
(vim.api.nvim_set_keymap "v" "<leader>gy"  "<cmd>lua custom_gitlinks_yank_v()<cr>" {})
; (vim.api.nvim_set_keymap "n" "<leader>gb"  "<cmd>lua custom_gitlinks_open_in_browser_n()<cr>" {:silent true})
; (vim.api.nvim_set_keymap "v" "<leader>gb"  "<cmd>lua custom_gitlinks_open_in_browser_v()<cr>" {})

nil
