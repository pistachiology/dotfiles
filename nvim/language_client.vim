set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['/Users/pistachio/.cargo/bin/rust-analyzer'],
    \ }

let g:LanguageClient_settingsPath='./language-client.json'

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>

nnoremap <silent> ed :call LanguageClient#textDocument_references()<CR>W

set completefunc=LanguageClient#complete

function! MaybeFormat() abort
    if !has_key(g:LanguageClient_serverCommands, &filetype)
        return
    endif

    call LanguageClient#textDocument_formatting_sync()
endfunction

autocmd BufWritePre * call MaybeFormat()

nmap <F5> <Plug>(lcn-menu)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(lcn-code-action)
nmap <leader>a  <Plug>(lcn-code-action)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(lcn-code-lens-action)

nmap <leader>s  <Plug>(lcn-symbols)

nmap <leader>ee <Plug>(lcn-explain-error)

nmap <leader>ls :echomsg call('LanguageClient#serverStatusMessage')<CR>

call deoplete#custom#var('omni', 'input_patterns', {
    \ 'rust': ["\.|::)\w*"],
    \})


let g:deoplete#enable_at_startup = 1

