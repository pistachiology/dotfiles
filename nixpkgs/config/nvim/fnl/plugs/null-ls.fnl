(fn setup []
  (local null-ls (require :null-ls))
  (local helper (require :null-ls.helpers))
  (local eslint (helper.conditional (fn [utils]
                                      (let [project-local-bin :node_modules/.bin/eslint
                                            eslint null-ls.builtins.diagnostics.eslint.with
                                            cfg {:command (or (and (utils.root_has_file project-local-bin)
                                                                   project-local-bin)
                                                              :eslint)}]
                                        (eslint cfg)))))
  (local eslint-format
         (helper.conditional (fn [utils]
                               (let [project-local-bin :node_modules/.bin/eslint
                                     eslint null-ls.builtins.formatting.eslint.with
                                     cfg {:command (or (and (utils.root_has_file project-local-bin)
                                                            project-local-bin)
                                                       :eslint)}]
                                 (eslint cfg)))))
  (local prettier (helper.conditional (fn [utils]
                                        (let [project-local-bin :node_modules/.bin/prettier
                                              prettier null-ls.builtins.formatting.prettier.with
                                              cfg {:command (or (and (utils.root_has_file project-local-bin)
                                                                     project-local-bin)
                                                                :prettier)}]
                                          (prettier cfg)))))
  (null-ls.config {:sources [prettier eslint eslint-format]}))
