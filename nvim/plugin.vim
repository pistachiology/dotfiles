call plug#begin()
" Thai keyboard
Plug 'chakrit/vim-thai-keys'

Plug 'google/vim-jsonnet'

Plug 'elzr/vim-json'

" Visual
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
" Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'mkitt/tabline.vim'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'romainl/vim-qf'
" Plug 'mboughaba/vim-lessmess'


" Plug 'sheerun/vim-polyglot'

" Plug 'junegunn/vim-easy-align'

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'terryma/vim-multiple-cursors'

" Autocomplete
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'Valloric/YouCompleteMe'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'ludovicchabant/vim-gutentags'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'


" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'sebdah/vim-delve'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/gem-ctags'
Plug 'tpope/vim-bundler'
Plug 'noprompt/vim-yardoc'

Plug 'majutsushi/tagbar'


" CSS & Preprocessors
"

Plug 'hail2u/vim-css3-syntax'                                     " CSS3 syntax (and syntax defined in some foreign specifications) support for Vim's built-in syntax/css.vim
Plug 'ap/vim-css-color'                                           " Highlight background of CSS colors
Plug 'cakebaker/scss-syntax.vim'                                  " Vim syntax file for scss (Sassy CSS)
Plug 'groenewege/vim-less'                                        " syntax for LESS (dynamic CSS)
Plug 'othree/csscomplete.vim'                                     " Update the bult-in CSS complete function to latest CSS standard
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"
" JavaScript
"

Plug 'pangloss/vim-javascript'
Plug 'neoclide/vim-jsx-improve', { 'for': [ 'javascript', 'js', 'jsx' ]}

Plug 'skywind3000/asyncrun.vim'
Plug 'editorconfig/editorconfig-vim'                              " EditorConfig support


"Typescript Plugins
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/tsuquyomi', { 'do': 'npm install -g typescript' }
Plug 'leafgarland/typescript-vim'
" Plug 'mhartington/deoplete-typescript'

" Rust
Plug 'rust-lang/rust.vim'

" PHP
" Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }


" Elixir
Plug 'c-brenn/phoenix.vim'
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

" Test
" Plug 'janko-m/vim-test'
" Terraform
Plug 'hashivim/vim-terraform'

" Utilities
Plug 'tomtom/tcomment_vim'

" Syntax Checker
Plug 'SirVer/ultisnips'

" Sessions
Plug 'tpope/vim-obsession'

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" Language Client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
"


" TOML
Plug 'cespare/vim-toml'

" Elm
Plug 'andys8/vim-elm-syntax'

" Fish
Plug 'dag/vim-fish'

" Python
Plug 'vim-python/python-syntax'

" DB
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" Vim wiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'plasticboy/vim-markdown'


" Initialize plugin system
call plug#end()

