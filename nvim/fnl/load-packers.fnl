(module load-packers
  {autoload {nvim aniseed.nvim
            core aniseed.core
            packer packer}})

(defn- plug [name]
  (let [(ok? val-or-err) (pcall require (.. :plugs. name))]
    (when (not ok?)
      (print (.. "plug error: " val-or-err)))))

(local pkgs {
  ;; Package manager
  :wbthomason/packer.nvim {}

  ;; Themes
  :tjdevries/colorbuddy.nvim {}
  :maaslalani/nordbuddy {:requires [:tjdevries/colorbuddy.nvim]
                         :plug :nordbuddy}
  ;; Navigation
  :nvim-telescope/telescope.nvim {:requires [:nvim-lua/plenary.nvim
                                             :nvim-lua/popup.nvim]
                                  :plug :telescope}
  :nvim-telescope/telescope-fzf-native.nvim {:run :make}
  :nvim-telescope/telescope-frecency.nvim {:requires [:tami5/sqlite.lua]}

  :kyazdani42/nvim-tree.lua {:requires [:kyazdani42/nvim-web-devicons]
                             :plug :nvim-tree}

  ;; LSP & Autocomplete
  :neovim/nvim-lspconfig {:plug :lspconfig}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/nvim-cmp {:plug :cmp}
  :PaterJason/cmp-conjure {:requires [:nvim-cmp :Olical/conjure]}

  ;; Languages stuffs
  :bakpakin/fennel.vim {:ft ["fennel"]}
  :Olical/aniseed {}
  :Olical/conjure {:tag :v4.23.0}

  ;; Utilities
  :dag/vim-fish {}
  :tpope/vim-sleuth {}
  :tpope/vim-dispatch {:opt true
                       :cmd ["Dispatch" "Make" "Focus" "Start"]}
  :andymass/vim-matchup {:event "VimEnter"}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"}
  :glacambre/firenvim {:run #(. vim.fn.firenvim#install 0) }
  :glepnir/galaxyline.nvim {:branch :main
                            :config #(require :statusline)
                            :requires [:kyazdani42/nvim-web-devicons]}

  ;; Git
  :lewis6991/gitsigns.nvim {:requires [:nvim-lua/plenary.nvim]
                            :plug :gitsigns}
  :TimUntersberger/neogit {:requires [:nvim-lua/plenary.nvim]
                            :plug :neogit}
  })

(packer.startup
  (fn [use]
    (each [name opts (pairs pkgs)]
      (-?> (. opts :plug) (plug))
      (use (core.assoc opts 1 name)))))
