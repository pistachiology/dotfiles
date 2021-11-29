{ config, pkgs, libs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;

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
