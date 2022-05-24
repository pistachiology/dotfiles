{ config, pkgs, libs, lib, ... }:
let
  tree-sitter = pkgs.tree-sitter.override {
    extraGrammars = {
      tree-sitter-nix = lib.importJSON ./tree-sitter-nix.json;
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
      mv ./lua $out
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
    ];
  };

  xdg.configFile."nvim/lua" = {
    source = nvim-lua-config.out;
    recursive = true;
  };

  xdg.configFile."nvim/boot.lua" = {
    source = ../config/nvim/init.lua;
  };
}