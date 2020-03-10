
" git gutter
set signcolumn=yes

" default vim mapping
nnoremap tn :tabnew<CR>

nnoremap <leader>0 10gt
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 8gt
nnoremap <leader>0 10gt

" quickfix
nnoremap q] :cn<CR>
nnoremap q[ :cp<CR>
let g:qf_max_height = 5


" fzf plugin
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction


let g:fzf_action = {
  \ 'ctrl-p': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <C-p> :Files<CR>
nnoremap <leader>s :Tags<space><C-R><C-W><space><CR>
nnoremap <leader>q :Rg<space><C-R><C-W><space><CR>
nnoremap <leader>a :Dash<space>
nnoremap <leader><leader>a :Dash<space><C-R><C-W><space><CR>

command! -bang -nargs=* Find call fzf#vim#grep('rg --files --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" -g "\\!vendor/*" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Ag
   \ call fzf#vim#grep(
   \   "rg --column --line-number --no-heading --color=always --smart-case -g '!vendor/*' ".shellescape(<q-args>), 1,
   \   <bang>0 ? fzf#vim#with_preview('up:60%')
   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
   \   <bang>0)
 
command! -bang -nargs=? -complete=dir Files
   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" NerdTree
map <C-\> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>  

let NERDTreeIgnore = ['node_modules', '\.pyc$', '_build']
let g:NERDTreeMouseMode = 3     " Single Click

" Ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions (public)',
        \ 'g:functions (private)',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:types',
        \ 'z:foo'
    \ ]
    \ }

" Autoformat
noremap <F3> :Autoformat<CR>

" Custom Commands
map <leader>e :call custom_command#run()<cr>
map <leader>d :call custom_command#set()<cr>

" Gutentags
" let g:gutentags_cache_dir = util#localpath('tags')
let g:gutentags_ctags_exclude = ['venv', 'build', 'static', 'node_modules']
let g:gutentags_ctags_extra_args = ['--options='.util#localpath('ctagsrc')]
let g:gutentags_ctags_exclude_wildignore = 0
" Temporary fix due to https://github.com/ludovicchabant/vim-gutentags/issues/167
au FileType gitcommit,gitrebase let g:gutentags_enabled=0

set termguicolors

" ALE
let g:ale_sign_column_always = 1
let g:ale_linters = {'ruby': ['rubocop']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_lint_on_text_changed = 'never'

" Language Server
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'css': ['vscode-css-languageserver-bin'],
    \ }

" autocmd filetype php LanguageClientStart

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_ruby_rubocop_exec = '/Users/pistachio/.rbenv/shims/rubocop'


" identify syntax
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Golang
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" turn off if slow
let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


nmap <F8> :TagbarToggle<CR>


" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
