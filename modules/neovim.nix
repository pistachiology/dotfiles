{ config, pkgs, libs, lib, ... }:
let
  tree-sitter = pkgs.tree-sitter.override {
    extraGrammars = {
      tree-sitter-kotlin = {
        url = "https://github.com/fwcd/tree-sitter-kotlin";
        rev = "a4f71eb9b8c9b19ded3e0e9470be4b1b77c2b569";
        sha256 = "sha256-aRMqhmZKbKoggtBOgtFIq0xTP+PgeD3Qz6DPJsAFPRQ=";
        fetchLFS = false;
        fetchSubmodules = false;
        deepClone = false;
        leaveDotGit = false;
      };

      tree-sitter-scala = {
        url = "https://github.com/tree-sitter/tree-sitter-scala";
        rev = "628e0aab6c2f7d31cf3b7d730f964d4fd9b340ee";
        sha256 = "sha256-LbVebyhVPKobPxosLDl21NGGtNlZ5gUhJN6fGX87iak=";
        fetchLFS = false;
        fetchSubmodules = false;
        deepClone = false;
        leaveDotGit = false;
      };
      /* Temporary patch until released on unstable branch */
      tree-sitter-bash = {
        url = "https://github.com/tree-sitter/tree-sitter-bash";
        rev = "77cf8a7cab8904baf1a721762e012644ac1d4c7b";
        sha256 = "sha256-UPMJ7iL8Y0NkAHtPDrkTjG1qFwr8rXuGqvsG+LTWqEY=";
        fetchLFS = false;
        fetchSubmodules = false;
        deepClone = false;
        leaveDotGit = false;
      };
      tree-sitter-hocon = {
        url = "https://github.com/antosha417/tree-sitter-hocon";
        rev = "c390f10519ae69fdb03b3e5764f5592fb6924bcc";
        sha256 = "sha256-9Zo3YYoo9mJ4Buyj7ofSrlZURrwstBo0vgzeTq1jMGw=";
        fetchLFS = false;
        fetchSubmodules = false;
        deepClone = false;
        leaveDotGit = false;
      };
    };
  };
  grammars = tree-sitter.allGrammars;
  stdenv = pkgs.stdenv;

  nvim-lua-config = stdenv.mkDerivation {
    name = "nvim-lua-config";
    src = ../config/nvim/fnl;

    unpackPhase = "false";

    buildInputs = with pkgs; [ fennel ripgrep ];

    phases = [ "buildPhase" "installPhase" ];

    buildPhase = ''
      mkdir fnl
      cp -r $src/* fnl/

      rg --type-add "fnl:*.fnl" -t fnl --files | sed -e 's/^fnl//' | sed -e 's/\.fnl$//' | xargs -I{} -d '\n' sh -c 'mkdir -p lua/$(dirname {}) && fennel --compile fnl/{}.fnl > lua/{}.lua'
    '';

    installPhase = ''
      mkdir -p $out
      mv ./lua $out/neovim-lua
    '';
  };
in
{
  home.packages = with pkgs; [
    nvim-lua-config
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.${if pkgs.stdenv.isDarwin then "dylib" else "so"}'
      luafile ${config.xdg.configHome}/nvim/boot.lua

      let g:slime_target = "tmux"
      let g:slime_default_config = {"socket_name": "default", "target_pane": ".2"}
      let g:slime_no_mappings = 1
      let g:slime_dont_ask_default = 1
      function SlimeOverride_EscapeText_scala(text)
        return a:text
      endfunction

      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldlevelstart=5

    '';

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: grammars))
      markdown-preview-nvim
      lightspeed-nvim
      vim-prisma
      vim-slime
      direnv-vim
      packer-nvim
      impatient-nvim
      lsp-status-nvim
      telescope-fzf-native-nvim
      ansible-vim
      vim-puppet
      neodev-nvim
    ];
  };

  xdg.configFile."nvim/lua" = {
    source = nvim-lua-config.out + "/neovim-lua";
    recursive = true;
  };

  xdg.configFile."nvim/boot.lua" = {
    source = ../config/nvim/init.lua;
  };
}
