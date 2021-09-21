(module plugs.nvim-tree
  {autoload {nvim aniseed.nvim}})

(fn noremap [mode from to]
  (nvim.set_keymap mode from to {:noremap true}))

(fn setup []
  (noremap :n :<C-\> ":NvimTreeToggle<cr>")
  (noremap :n :<M-\> ":NvimTreeFindFile<cr>"))

(setup)
