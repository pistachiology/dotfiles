"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"


let g:onedark_terminal_italics = 1
colorscheme onedark
" set background=dark " for the light version
" let g:one_allow_italics = 1 " I love italic for comments
"
let g:purple = "#c678dd"


" italic !!!
hi jsxAttrib cterm=italic gui=italic
hi Define cterm=italic gui=italic
hi Keyword cterm=italic gui=italic
hi Exception cterm=italic gui=italic
hi Conditional cterm=italic gui=italic
hi Statement cterm=italic gui=italic
hi Label cterm=italic gui=italic
hi Type cterm=italic gui=italic

" Ruby italic
hi rubyClass cterm=italic gui=italic
hi rubyFunction cterm=italic gui=italic
hi rubySymbol cterm=italic gui=italic
hi rubyConstant cterm=italic gui=italic
hi rubyControl cterm=italic gui=italic
hi rubyBlock ctermfg=170 guifg=#c678dd cterm=italic, gui=italic
hi rubyInclude cterm=italic gui=italic


" Tabbar

hi TabLineFill cterm=none ctermfg=grey  ctermbg=cyan
hi TabLine     cterm=none ctermfg=white ctermbg=cyan
hi TabLineSel  cterm=none ctermfg=black ctermbg=white

" Golang
hi goDeclaration cterm=italic gui=italic
