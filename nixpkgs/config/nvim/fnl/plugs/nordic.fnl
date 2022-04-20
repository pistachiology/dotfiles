(module plugs.nordic {})

((. (require :nordic) :colorscheme)
 {:underline_option "none"
  :italic true
  :italic_comments false
  :custom_colors (fn [c s cs] (let [comments ["TSComment"       ; TS
                                                 "Comment"          ; VL
                                                 "manFooter"        ; man
                                                 ; rust
                                                 "rustCommentLine" 
                                                 "rustCommentBlock"
                                                 ; vim
                                                 "vimCommentTitle"
                                                 "vimCommentLine"
                                                 ]
                                    folded ["Folded" "FoldColumn"]]
                                  [[comments "#63718b" c.none cs.comments]
                                   [folded "#63718b" c.dark_black ]]))})


