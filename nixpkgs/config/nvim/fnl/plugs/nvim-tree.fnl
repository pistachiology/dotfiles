(module plugs.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree}})

(fn noremap [mode from to]
  (nvim.set_keymap mode from to {:noremap true}))

(fn do-setup []
  (tree.setup {:git {:enable false :ignore false :timeout 1}})

  (noremap :n :<C-\> ":NvimTreeToggle<cr>")
  (noremap :n :<M-\> ":NvimTreeFindFile<cr>")
  (noremap :n :<leader>nt ":NvimTreeToggle<cr>")
  (noremap :n :<leader>nf ":NvimTreeFindFile<cr>"))

(do-setup)
