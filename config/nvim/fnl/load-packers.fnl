(local packer (require :packer))
(local my-galaxy (require :plugs.galaxyline))
(local u (require :utils))

(fn plug [name]
  (let [(ok? val-or-err) (pcall require (.. :plugs. name))]
    (when (not ok?)
      (print (.. "plug error: " val-or-err)))))

(local pkgs {;; Package manager
             :wbthomason/packer.nvim {}
             ;; Themes
             :tjdevries/colorbuddy.nvim {}
             :andersevenrud/nordic.nvim {:requires [:tjdevries/colorbuddy.nvim]
                                         :plug :nordic}
             ;; Navigation
             :nvim-telescope/telescope.nvim {:requires [:nvim-lua/plenary.nvim
                                                        :nvim-lua/popup.nvim]
                                             :plug :telescope}
             ; :nvim-telescope/telescope-fzf-native.nvim {:run :make}
             :nvim-telescope/telescope-frecency.nvim {:requires [:tami5/sqlite.lua]}
             :nvim-telescope/telescope-ui-select.nvim {}
             :kyazdani42/nvim-tree.lua {:requires [:kyazdani42/nvim-web-devicons]
                                        :plug :nvim-tree}
             ;; DB
             :tpope/vim-dadbod {}
             :kristijanhusak/vim-dadbod-ui {}
             ;; LSP & Autocomplete
             :neovim/nvim-lspconfig {:plug :lspconfig
                                     :requires [:jose-elias-alvarez/null-ls.nvim]}
             :hrsh7th/cmp-nvim-lsp {}
             :hrsh7th/cmp-buffer {}
             :hrsh7th/nvim-cmp {:plug :cmp}
             :PaterJason/cmp-conjure {:requires [:hrsh7th/nvim-cmp
                                                 :Olical/conjure]}
             :hrsh7th/vim-vsnip {}
             :hrsh7th/cmp-vsnip {:requires [:hrsh7th/nvim-cmp
                                            :hrsh7th/vim-vsnip]}
             :jose-elias-alvarez/null-ls.nvim {:requires [:nvim-lua/plenary.nvim]}
             :ray-x/lsp_signature.nvim {}
             ;; Languages stuffs
             :bakpakin/fennel.vim {:ft [:fennel]}
             :Olical/aniseed {}
             :Olical/conjure {:plug :conjure :tag :v4.23.0}
             ;;; Scala
             :scalameta/nvim-metals {:requires [:nvim-lua/plenary.nvim]
                                     :plug :metals-lsp}
             :derekwyatt/vim-scala {}
             ;;; Rust
             :simrat39/rust-tools.nvim {:requires [:neovim/nvim-lspconfig]}
             ;;; Kotlin
             :udalov/kotlin-vim {}
             ;;; Others
             :vmchale/just-vim {}
             ;; Debug
             :mfussenegger/nvim-dap {:plug :dap}
             ;; Utilities
             :dag/vim-fish {}
             ;; :tpope/vim-sleuth {}
             :tpope/vim-dispatch {}
             :tpope/vim-fugitive {}
             :andymass/vim-matchup {:event :VimEnter}
             :glacambre/firenvim {:run #(vim.fn.firenvim#install 0)
                                  :plug :firenvim}
             :glepnir/galaxyline.nvim {:branch :main
                                       :config (my-galaxy.run)
                                       :requires [:kyazdani42/nvim-web-devicons]}
             :b3nj5m1n/kommentary {}
             :junegunn/vim-easy-align {}
             ;; Git
             :ruifm/gitlinker.nvim {:requires [:nvim-lua/plenary.nvim]
                                       :plug :gitlinker}
             :lewis6991/gitsigns.nvim {:requires [:nvim-lua/plenary.nvim]
                                       :plug :gitsigns}
             :TimUntersberger/neogit {:requires [:nvim-lua/plenary.nvim]
                                      :plug :neogit}})


(packer.startup (fn [use]
                  (each [name opts (pairs pkgs)]
                    (-?> (. opts :plug) (plug))
                    (use (u.assoc opts 1 name)))))
