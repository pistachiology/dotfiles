{ config, pkgs, pkgs-unstable, libs, lib, ... }:
let
  /* Treesitter always broken in nix ;( */
  grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: grammars);
  stdenv = pkgs.stdenv;

  nvim-lua-config = stdenv.mkDerivation {
    name = "nvim-lua-config";
    src = ../config/nvim;

    unpackPhase = "false";

    buildInputs = with pkgs; [ fennel ripgrep ];

    phases = [ "buildPhase" "installPhase" ];

    buildPhase = ''
      mkdir fnl
      cp -r $src/fnl/* fnl/

      curdir=$(pwd)
      pushd "$src"
      for dir in "lua" "ftplugin"
      do
        find "$dir" -type f -exec install -Dm 755 "{}" "$curdir/{}" \;
      done
      popd

      rg --type-add "fnl:*.fnl" -t fnl --files | sed -e 's/^fnl//' | sed -e 's/\.fnl$//' | xargs -I{} -d '\n' sh -c 'mkdir -p lua/$(dirname {}) && fennel --compile fnl/{}.fnl > lua/{}.lua'
    '';

    installPhase = ''
      mkdir -p $out
      mv ./lua $out/lua
      mv ./ftplugin $out/ftplugin
    '';
  };

  java-styleguide = stdenv.mkDerivation
    rec {
      pname = "java-styleguide";
      version = "1.0.0";

      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml";
        sha256 = "sha256-51Uku2fj/8iNXGgO11JU4HLj28y7kcSgxwjc+r8r35E=";
      };

      nativeBuildInputs = [ ];

      outputs = [ "out" ];

      buildCommand = ''
        mkdir -p $out/share/java
        cp $src $out/share/java/style.xml
      '';
    };


  jdtls = with pkgs; jdt-language-server.override { };

  # https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/2985
  lombok = stdenv.mkDerivation {
    name = "lombok-snapshot";
    src = ../static/lombok;

    phases = [ "unpackPhase" "installPhase" ];

    installPhase = ''
        mkdir -p $out/share/java
        cp $src/lombok-1.18.31-3454.jar $out/share/java/lombok.jar
    '';

  };
  lombokjar = lombok.out + "/share/java/lombok.jar";
  jdt = pkgs.writeShellApplication {
    name = "jdt";

    runtimeInputs = [ jdtls lombok ];

    text = ''
      ${jdtls}/bin/jdtls --jvm-arg=-javaagent:${lombokjar} "$@"
    '';
  };

in
{
  /* nixpkgs.overlays = overlays; */

  home.packages = ( 
    [
      nvim-lua-config
      java-styleguide
    ]) ++ [ jdtls lombok jdt ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.${if pkgs.stdenv.isDarwin then "dylib" else "so"}'
      luafile ${config.xdg.configHome}/nvim/global.lua
      luafile ${config.xdg.configHome}/nvim/boot.lua

      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldlevelstart=5
    '';

    plugins = let 
        # nix does not work really well with lazy.nvim
        stable = with pkgs.vimPlugins; [
          ansible-vim
          direnv-vim
          leap-nvim
          lsp-status-nvim
          markdown-preview-nvim
          neodev-nvim
          nvim-osc52
          lazy-nvim
          sqlite-lua

          plenary-nvim
          popup-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          telescope-frecency-nvim
          telescope-ui-select-nvim

          vim-prisma
          vim-puppet
          fzf-lua
          zk-nvim
          vim-jinja
        ];

        unstable = with pkgs-unstable.vimPlugins; [
          harpoon2
        ];
    in [treesitter] ++ stable ++ unstable;

  };

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter;
  };

  xdg.configFile."nvim/lua" = {
    source = nvim-lua-config.out + "/lua";
    recursive = true;
  };

  xdg.configFile."nvim/ftplugin" = {
    source = nvim-lua-config.out + "/ftplugin";
    recursive = true;
  };

  xdg.configFile."nvim/global.lua".text =
    let
      java-styleguide-path = java-styleguide.out + "/share/java/style.xml";
      default-path = "${jdt}/bin/jdt";
      bin-path = if builtins.pathExists default-path then
        default-path
      else
        "${jdt}/bin/jdt-language-server";
    in
    ''
       NIX_GLOBAL = {}
       NIX_GLOBAL["jdtls"] = {
          styleguide_path = "${java-styleguide-path}";
          jdt_bin_path = "${bin-path}";
      }
    '';
  xdg.configFile."nvim/after/syntax/markdown.vim".text = ''
    " markdownWikiLink is a new region
    syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
    " markdownLinkText is copied from runtime files with 'concealends' appended
    syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
    " markdownLink is copied from runtime files with 'conceal' appended
    syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
  '';

  xdg.configFile."nvim/boot.lua" = {
    source = ../config/nvim/init.lua;
  };
}
