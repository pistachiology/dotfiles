(module plugs.galaxyline
  {autoload {nvim aniseed.nvim
            a aniseed.core
            gl galaxyline
            fileinfo galaxyline.provider_fileinfo
            git galaxyline.provider_vcs}})

;; Thanks to
;; https://raw.githubusercontent.com/voitd/dotfiles/master/.config/nvim/lua/plugins/statusline.lua

(local nord_colors {
  :bg "NONE"
  :fg "#81A1C1"
  :line_bg "#3b4252"
  :lbg "#5E81AC"
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
})


;; Utils
(local buffer_not_empty (fn []
                          (~= (nvim.fn.empty (nvim.fn.expand "%:t")) 1)))

(local checkwidth (fn []
                    (local squeeze-width (/ (nvim.fn.winwidth 0) 2))
                    (> squeeze-width 40)))

(fn run []
  (tset gl :short_line_list ["packager"])

  (local mid 
    {1 {:ShowLspClient {:provider :GetLspClient
                       :condition (fn [] (let [tbl {:dashboard true "" true :scala true}]
                                    (if (. tbl vim.bo.filetype) false true)))
                       :icon "   "
                       :highlight [nord_colors.cyan :NONE :bold]}}

     2 {:MetalsClient  {:provider #(let [status vim.g.metals_status] 
                                           (string.format "Metals: %s " (or status "Unknown")))
                        :condition #(let [tbl {:scala true :sbt true}]
                                    (if (. tbl vim.bo.filetype) true false))
                        :icon "   "
                        :highlight [nord_colors.cyan nord_colors.line_bg :bold]}}
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
                                                :R nord_colors.purple
                                                :Rv nord_colors.purple
                                                :cv nord_colors.red
                                                :ce nord_colors.red
                                                :r nord_colors.cyan
                                                :rm nord_colors.cyan
                                                "r?" nord_colors.cyan
                                                "!" nord_colors.red
                                                :t nord_colors.red
                                                })
                             (vim.cmd (.. "hi GalaxyViMode guifg=" (. mode-color (vim.fn.mode))))
                             "     "
                             )}}

     3 {:FileIcon {:provider :FileIcon
                   :condition buffer_not_empty
                   :separator " "
                   :separator_highlight [nord_colors.purple nord_colors.line_bg]
                   :highlight [(fileinfo.get_file_icon_color) nord_colors.line_bg]}}

     4 {:FileName {:provider (fn [] (nvim.fn.expand "%:F"))
                   :condition buffer_not_empty
                   :separator " "
                   :separator_highlight [nord_colors.purple nord_colors.line_bg]
                   :highlight [nord_colors.purple nord_colors.line_bg :bold]}}
     })


  (local right
    {1 {:GitIcon {:provider #"  "
                  :condition git.check_git_workspace
                  :highlight [nord_colors.orange nord_colors.line_bg]}}

     2 {:GitBranch {:provider :GitBranch
                    :condition git.check_git_workspace
                    :separator " "
                    :separator_highlight [nord_colors.purple nord_colors.line_bg]
                    :highlight [nord_colors.purple nord_colors.line_bg :bold]}}

     3 {:DiffAdd {:provider :DiffAdd
                  :condition checkwidth
                  :icon "   "
                  :highlight [nord_colors.green nord_colors.line_bg]}}

     4 {:DiffModified {:provider :DiffModified
                       :condition checkwidth
                       :icon "   "
                       :highlight [nord_colors.yellow nord_colors.line_bg]}}

     5 {:DiffRemove {:provider :DiffRemove
                     :condition checkwidth
                     :icon "   "
                     :highlight [nord_colors.red nord_colors.line_bg]}}

     6 {:LineColumn {:provider :LineColumn
                     :separator ""
                     :separator_highlight [nord_colors.blue nord_colors.line_bg]
                     :highlight [nord_colors.gray nord_colors.line_bg]}}

     7 {:FileSize {:provider :FileSize
                   :separator " "
                   :condition buffer_not_empty
                   :separator_highlight [nord_colors.blue nord_colors.line_bg]
                   :highlight [nord_colors.fg nord_colors.line_bg]}}

     8 {:DiagnosticError {:provider :DiagnosticError
                          :icon " "
                          :separator " "
                          :condition buffer_not_empty
                          :separator_highlight [nord_colors.bg nord_colors.bg]
                          :highlight [nord_colors.red nord_colors.line_bg]}}

     9 {:DiagnosticWarn {:provider :DiagnosticWarn 
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

{:run run}
