(module plugs.nvim-tree
  {require {nvim aniseed.nvim}})

(defn- noremap [mode from to]
  (nvim.set_keymap mode from to {:noremap true}))

(defn setup []
  (noremap :n :<C-\> ":NvimTreeToggle<cr>")
  (noremap :n :<M-\> ":NvimTreeFindFile<cr>"))


(setup)
