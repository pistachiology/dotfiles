{ config, pkgs, libs, lib, ... }:
let
  tree-sitter = pkgs.tree-sitter.override {
    extraGrammars = {
      tree-sitter-nix = lib.importJSON ./tree-sitter-nix.json;
    };
  };
  grammars = tree-sitter.allGrammars;
in
{
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
    ];
  };


  xdg.configFile."nvim/fnl" =
    {
      source = ../config/nvim/fnl;
      recursive = true;
    };

  xdg.configFile."nvim/boot.lua" = {
    source = ../config/nvim/init.lua;
  };
}
