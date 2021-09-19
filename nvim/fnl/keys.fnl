(module keys
  {require {nvim aniseed.nvim}})

(defn nnoremap [key value]
  nvim.set_keymap :n key value {:noremap false})

(defn inoremap [key value]
  nvim.set_keymap :i key value {:noremap true})

(defn setup []
  (nnoremap :tn ":tabnew<cr>")

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

  (nnoremap "q]" ":cn<cr>")
  (nnoremap "q[" ":cp<cr>")
  (set nvim.g.qf_max_height 5))

(setup)
