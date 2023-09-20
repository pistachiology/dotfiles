{ config, pkgs, libs, lib, ... }:
let
  /* Treesitter always broken in nix ;( */
  tree-sitter = pkgs.vimPlugins.nvim-treesitter;
  grammars = tree-sitter.allGrammars;
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
  lombok = with pkgs; pkgs.lombok.override { };

  lombokjar = lombok.out + "/share/java/lombok.jar";
  jdt = pkgs.writeShellApplication {
    name = "jdt";

    runtimeInputs = [ jdtls lombok ];

    text = ''
      export JAVA_OPTS="-javaagent:${lombokjar}"
      ${jdtls}/bin/jdt-language-server "$@"
    '';
  };

in
{
  /* nixpkgs.overlays = overlays; */

  home.packages = (with pkgs;
    [
      nvim-lua-config
      java-styleguide
    ]) ++ [ jdtls lombok jdt ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;

    extraConfig = ''
      let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.${if pkgs.stdenv.isDarwin then "dylib" else "so"}'
      luafile ${config.xdg.configHome}/nvim/global.lua
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
      ansible-vim
      direnv-vim
      impatient-nvim
      lightspeed-nvim
      lsp-status-nvim
      markdown-preview-nvim
      neodev-nvim
      nvim-jdtls
      nvim-osc52
      packer-nvim
      telescope-fzf-native-nvim
      venn-nvim
      vim-prisma
      vim-puppet
      vim-slime
      zk-nvim
    ];
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
    in
    ''
       NIX_GLOBAL = {}
       NIX_GLOBAL["jdtls"] = {
          styleguide_path = "${java-styleguide-path}";
          jdt_bin_path = "${jdt}/bin/jdt";
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
