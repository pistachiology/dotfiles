{ config, pkgs, libs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.${if pkgs.stdenv.isDarwin then "dylib" else "so"}'
      luafile ${config.xdg.configHome}/nvim/boot.lua
    '';

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: pkgs.tree-sitter.allGrammars))
      markdown-preview-nvim
      vim-prisma
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
