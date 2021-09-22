(fn setup []
  (local formatter (require :formatter))
  (formatter.setup {:filetype {:javascript [#{:exe :prettier
                                             :stdin true
                                             :args ["--stdin-filepath" 
                                                    (vim.fn.fnameescape (vim.api.nvim_buf_get_name 0))
                                                    "--single-quote"]}]}})
  )

(setup)
