(local lazy (require :lazy))
(local my-galaxy (require :plugs.galaxyline))

(fn plug [name]
  (let [(ok? val-or-err) (pcall require (.. :plugs. name))]
    (when (not ok?)
      (print (.. "plug error: " val-or-err)))))

(local pkgs {
             ;; Themes
             :tjdevries/colorbuddy.nvim {}

             :nvim-treesitter/nvim-treesitter {:dev true}

             :jbyuki/venn.nvim {}
             :andersevenrud/nordic.nvim {:dependencies [:tjdevries/colorbuddy.nvim]
                                         :plug :nordic}
             ;; Navigation
             ; :nvim-telescope/telescope.nvim {:dependencies [:nvim-lua/plenary.nvim
             ;                                                :nvim-lua/popup.nvim]
             ;                                 :plug :telescope
             ;                                 :version "0.1.6"}
             ; :nvim-telescope/telescope-fzf-native.nvim {:run :make}
             ; :nvim-telescope/telescope-frecency.nvim {:dependencies [:tami5/sqlite.lua]}
             ; :nvim-telescope/telescope-ui-select.nvim {}
             :kyazdani42/nvim-tree.lua {:dependencies [:kyazdani42/nvim-web-devicons]
                                        :plug :nvim-tree}
             ;; DB
             :rafamadriz/friendly-snippets {}
             :tpope/vim-dadbod {}
             :kristijanhusak/vim-dadbod-ui {}
             ;; LSP & Autocomplete
             :neovim/nvim-lspconfig {:plug :lspconfig
                                     :dependencies [:nvimtools/none-ls.nvim]}
             :hrsh7th/cmp-nvim-lsp {}
             :hrsh7th/cmp-buffer {}
             :hrsh7th/nvim-cmp {:plug :cmp}
             ; :PaterJason/cmp-conjure {:dependencies [:hrsh7th/nvim-cmp
             ;                                         :Olical/conjure]}
             :hrsh7th/vim-vsnip {}
             :hrsh7th/cmp-vsnip {:dependencies [:hrsh7th/nvim-cmp
                                                :hrsh7th/vim-vsnip]}
             :nvimtools/none-ls.nvim {:dependencies [:nvim-lua/plenary.nvim :nvimtools/none-ls-extras.nvim]}
             :ray-x/lsp_signature.nvim {}
             ;; Languages stuffs
             :bakpakin/fennel.vim {:ft [:fennel]}
             ; :Olical/aniseed {}
             ; :Olical/conjure {:plug :conjure :version :v4.23.0}
             ;;; Scala
             :scalameta/nvim-metals {:dependencies [:nvim-lua/plenary.nvim]
                                     :plug :metals-lsp}
             :derekwyatt/vim-scala {}
             ;;; Rust
             :simrat39/rust-tools.nvim {:dependencies [:neovim/nvim-lspconfig]}
             ;;; Kotlin
             :udalov/kotlin-vim {}
             ;;; Others
             :vmchale/just-vim {}

             :ggandor/leap.nvim {:keys {1 :s :mode [:n :x :o] :desc "Leap forward to"}
                                       {2 :S :mode [:n :x :o] :desc "Leap backward to"}
                                       {3 :gs :mode [:n :x :o] :desc "Leap from windows"}
                                :dependencies [:tpope/vim-repeat]
                                :config (fn [_ opts]
                                          (local leap (require :leap))
                                          (each [k v (pairs opts)]
                                            (tset leap.opts k v))
                                          (leap.create_default_mappings)
                                          (vim.keymap.del [:x :o] :x)
                                          (vim.keymap.del [:x :o] :X))}
             :tpope/vim-repeat {:event :VeryLazy}

             ;; Debug
             :mfussenegger/nvim-dap {:plug :dap}
             :mfussenegger/nvim-jdtls {}
             ;; Utilities
             :dag/vim-fish {}
             ;; :tpope/vim-sleuth {}
             :tpope/vim-dispatch {}
             :tpope/vim-fugitive {}
             :andymass/vim-matchup {:event :VimEnter}
             :glacambre/firenvim {:build #(vim.fn.firenvim#install 0)
                                  :plug :firenvim}
             :glepnir/galaxyline.nvim {:branch :main
                                       :config #(my-galaxy.run)
                                       :dependencies [:kyazdani42/nvim-web-devicons]}
             :b3nj5m1n/kommentary {}
             :junegunn/vim-easy-align {}
             ;; Git
             :ruifm/gitlinker.nvim {:dependencies [:nvim-lua/plenary.nvim]
                                    :plug :gitlinker}
             :lewis6991/gitsigns.nvim {:dependencies [:nvim-lua/plenary.nvim]
                                       :plug :gitsigns}})
             ; :TimUntersberger/neogit {:dependencies [:nvim-lua/plenary.nvim]
             ;                          :plug :neogit}})
(let [set-if-nil (fn  [opts key a]
                   (if (= nil (?. opts key)) (tset opts key a) (. opts key)))]

  (lazy.setup {:dev {:path "~/.local/share/nvim/nix" :fallback false}
               :performance {:reset_packpath false :rtp {:reset false}}
               :spec (icollect [name opts (pairs pkgs)]
                        (doto opts
                          (set-if-nil :config #(-?> (. opts :plug) (plug)))
                          (tset 1 name)))}))


