
let s:vim_platform = "mac"
let s:path_sep = '/'
let s:vim_home = expand("<sfile>:h:h")

" Utilities function
function! util#localpath(...) abort
    return s:vim_home.s:path_sep.join(a:000, s:path_sep)
endfunction
