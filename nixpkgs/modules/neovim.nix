{ config, pkgs, libs, lib, ... }:
let
  version = "0.6";
  overlays = [
    (final: prev: {
      neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (attrs: {
        /*
          need to wait until PR is merged 
          https://github.com/NixOS/nixpkgs/pull/148040/files
        */
        version = version;
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "v${version}";
          sha256 = "sha256-mVVZiDjAsAs4PgC8lHf0Ro1uKJ4OKonoPtF59eUd888=";
        };
      });
    })
  ];
in
{
  nixpkgs.overlays = overlays;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    package = pkgs.neovim-unwrapped;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.${if pkgs.stdenv.isDarwin then "dylib" else "so"}'
      luafile ${config.xdg.configHome}/nvim/boot.lua
    '';

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: pkgs.tree-sitter.allGrammars))
    ];
  };


  xdg.configFile."nvim/fnl" = {
    source = ../config/nvim/fnl;
    recursive = true;
  };

  xdg.configFile."nvim/boot.lua" = {
    source = ../config/nvim/init.lua;
  };

  xdg.configFile."nvim/parser/fennel.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-fennel}/parser";
}
