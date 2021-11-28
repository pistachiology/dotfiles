
(fn setup []
  (set vim.g.conjure#client#clojure#nrepl#eval#auto_require false)
  (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false))

(setup)
