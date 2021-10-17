(module plugs.galaxyline {autoload {a aniseed.core}})

;; Thanks to
;; https://raw.githubusercontent.com/voitd/dotfiles/master/.config/nvim/lua/plugins/statusline.lua

(local nord_colors {
                    :bg :NONE
                    :fg "#81A1C1"
                    :line_bg "#2e3440"
                    :lbg :NONE
                    :fg_green "#8FBCBB"
                    :yellow "#EBCB8B"
                    :cyan "#A3BE8C"
                    :darkblue "#81A1C1"
                    :green "#8FBCBB"
                    :orange "#D08770"
                    :purple "#B48EAD"
                    :magenta "#BF616A"
                    :gray "#616E88"
                    :blue "#5E81AC"
                    :red "#BF616A"
                    :bright_cyan "#88c0d0"

                    :nord0 "#2e3440"
                    :statusline "#4c566a"
                    })


;; Utils
(local buffer_not_empty #(~= (vim.fn.empty (vim.fn.expand "%:t")) 1))

(local checkwidth #(let [squeeze-width (/ (vim.fn.winwidth 0) 2)]
                     (> squeeze-width 40)))

(fn execute-galaxy []
  ; just hack for installation
  (when (= vim.env.SETUP "true")
    (lua "return {}"))

  (local gl (require :galaxyline))
  (local fileinfo (require :galaxyline.provider_fileinfo))
  (local git (require :galaxyline.provider_vcs))

  (tset gl :short_line_list ["packager"])

                  :separator_highlight [nord_colors.fg nord_colors.line_bg]

  (local right-separator "")
  (local left-separator "")

  (local show-lsp? #(let [tbl {:dashboard true "" true :scala true}]
                      (if (. tbl vim.bo.filetype) false true)))

  (local show-metals? #(let [tbl {:scala true :sbt true}]
                         (if (. tbl vim.bo.filetype) true false)))

  (local mid 
    {1 {:CurlyRight {:provider #left-separator
                     :condition #(or (show-lsp?) (show-metals?))
                     :highlight [nord_colors.line_bg nord_colors.statusline :bold]}}

     2 {:ShowLspClient {:provider :GetLspClient
                        :condition show-lsp?
                        :icon "    "
                        :highlight [nord_colors.cyan nord_colors.line_bg :bold]}}

     3 {:MetalsClient  {:provider #(let [idle? #(if (= $1 "") "Idle" $1)
                                         status (or (idle? vim.g.metals_status) "Unknown")] 
                                     (string.format "Metals: %s " status))
                        :condition show-metals?
                        :icon "    "
                        :highlight [nord_colors.cyan nord_colors.line_bg :bold]}}

     4 {:Padding {:provider #"  "
                  :condition #(or (show-lsp?) (show-metals?))
                  :highlight [nord_colors.fg nord_colors.nord0 :bold]}}

     5 {:CurlyLeft {:provider #right-separator
                    :condition #(or (show-lsp?) (show-metals?))
                    :separator_highlight [nord_colors.fg nord_colors.line_bg]
                    :highlight [nord_colors.line_bg nord_colors.statusline :bold]}}


     })

  (local left 
    {1 {:FirstElement {:provider #"▊ "
                       :highlight [nord_colors.blue nord_colors.line_bg]}}

     2 {:ViMode {:highlight [nord_colors.red nord_colors.line_bg "bold"]
                 :provider (fn [] 
                             ;; auto change color according the vim mode
                             (local mode-color {
                                                :n nord_colors.magenta
                                                :i nord_colors.green
                                                :v nord_colors.blue
                                                "" nord_colors.blue
                                                :V nord_colors.blue
                                                :c nord_colors.red
                                                :no nord_colors.magenta
                                                :s nord_colors.orange
                                                :S nord_colors.orange
                                                "" nord_colors.orange
                                                :ic nord_colors.yellow
                                                :R nord_colors.fg
                                                :Rv nord_colors.fg
                                                :cv nord_colors.red
                                                :ce nord_colors.red
                                                :r nord_colors.cyan
                                                :rm nord_colors.cyan
                                                "r?" nord_colors.cyan
                                                "!" nord_colors.red
                                                :t nord_colors.red
                                                })
                             (vim.cmd (.. "hi GalaxyViMode guifg=" (. mode-color (vim.fn.mode))))
                             " "
                             )}}

     3 {:FileIcon {:provider :FileIcon
                   :condition buffer_not_empty
                   :separator " "
                   :separator_highlight [nord_colors.fg nord_colors.line_bg]
                   :highlight [(fileinfo.get_file_icon_color) nord_colors.line_bg]}}

     4 {:FileName {:provider :FileName
                   :condition buffer_not_empty
                   :highlight [nord_colors.fg nord_colors.line_bg :bold]}}

     5 {:CurlyLeft {:provider #right-separator
                    :highlight [nord_colors.line_bg nord_colors.statusline :bold]}}

     })


  (local right
    {1 {:CurlyRight {:provider #left-separator
                      :highlight [nord_colors.line_bg nord_colors.statusline :bold]}}

     2 {:GitIcon {:provider #" "
                  :condition git.check_git_workspace
                  :highlight [nord_colors.orange nord_colors.line_bg]}}

     3 {:GitBranch {:provider :GitBranch
                    :condition git.check_git_workspace
                    :separator " "
                    :separator_highlight [nord_colors.fg nord_colors.line_bg]
                    :highlight [nord_colors.fg nord_colors.line_bg :bold]}}

     4 {:DiffAdd {:provider :DiffAdd
                  :condition checkwidth
                  :separator " "
                  :icon "   "
                  :separator_highlight [nord_colors.fg nord_colors.line_bg]
                  :highlight [nord_colors.green nord_colors.line_bg]}}

     5 {:DiffModified {:provider :DiffModified
                       :condition checkwidth
                       :separator_highlight [nord_colors.fg nord_colors.line_bg]
                       :icon "   "
                       :highlight [nord_colors.yellow nord_colors.line_bg]}}

     6 {:DiffRemove {:provider :DiffRemove
                     :condition checkwidth
                     :icon "   "
                     :highlight [nord_colors.red nord_colors.line_bg]}}

     7 {:LineColumn {:provider :LineColumn
                     :separator ""
                     :separator_highlight [nord_colors.blue nord_colors.line_bg]
                     :highlight [nord_colors.gray nord_colors.line_bg]}}

     8 {:FileSize {:provider :FileSize
                   :separator " "
                   :condition buffer_not_empty
                   :separator_highlight [nord_colors.blue nord_colors.line_bg]
                   :highlight [nord_colors.fg nord_colors.line_bg]}}

     9 {:DiagnosticError {:provider :DiagnosticError
                          :icon " "
                          :separator " "
                          :condition buffer_not_empty
                          :separator_highlight [nord_colors.bg nord_colors.bg]
                          :highlight [nord_colors.red nord_colors.line_bg]}}

     10 {:DiagnosticWarn {:provider :DiagnosticWarn 
                         :icon " "
                         :condition buffer_not_empty
                         :separator_highlight [nord_colors.bg nord_colors.bg]
                         :highlight [nord_colors.yellow nord_colors.line_bg]}}
     })


(local short_line_left 
  {1 {:BufferType {:provider :FileIcon
                   :separtor " "
                   :separator_highlight [nord_colors.NONE nord_colors.lbg]
                   :highlight [nord_colors.blue nord_colors.lbg :bold]}}
   2 {:SFileName  {:provider :SFileName
                   :condition buffer_not_empty
                   :highlight [nord_colors.blue nord_colors.lbg :bold]}}
   })


(local short_line_right 
  {1 {:BufferIcon {:provider :BufferIcon
                   :highlight [nord_colors.fg nord_colors.lbg]}}
   })



(a.assoc gl.section
         :mid mid
         :left left
         :right right
         :short_line_left short_line_left
         :short_line_right short_line_right)
)



; not converted yet

;section.right[10] = {
                      ;  DiagnosticInfo = {
                                           ;    -- separator = " ",
                                           ;    provider = "DiagnosticInfo",
                                           ;    icon = " ",
                                           ;    highlight = {nord_colors.green, nord_colors.line_bg},
                                           ;    separator_highlight = {nord_colors.bg, nord_colors.bg}
                                           ;  }
                      ;}
;
;section.right[11] = {
                      ;  DiagnosticHint = {
                                           ;    provider = "DiagnosticHint",
                                           ;    -- separator = " ",
                                           ;    icon = " ",
                                           ;    highlight = {nord_colors.blue, nord_colors.line_bg},
                                           ;    separator_highlight = {nord_colors.bg, nord_colors.bg}
                                           ;  }
                      ;}

{:run execute-galaxy}
