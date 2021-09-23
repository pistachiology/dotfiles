
(fn setup []
  (set nvim.g.conjure#client#clojure#nrepl#eval#auto_require false)
  (set nvim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
  )

(setup)
