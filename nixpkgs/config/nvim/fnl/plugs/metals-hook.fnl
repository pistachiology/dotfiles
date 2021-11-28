(vim.cmd "

augroup lsp
  au!
  au FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc
  au FileType scala,sbt lua require('plugs.metals').setup()
augroup end
")

