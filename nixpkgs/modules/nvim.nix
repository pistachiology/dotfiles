{ config, pkgs, libs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
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
}
