{ config, pkgs, libs, ... }:

let
  overlays = [
    (final: prev: {
      fnlfmt = prev.fnlfmt.overrideAttrs (attrs: rec {
        version = "0.2.3";
        src = prev.fetchFromSourcehut {
          owner = "~technomancy";
          repo = "fnlfmt";
          rev = version;
          sha256 = "sha256-FKmr5Xihyk+ikYN8WXBq5UFJziwEb8xaUBswNt/JMBg=";
        };
      });
    })
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;

  home.packages = with pkgs; [
    # GNU stuffs for better cli experience
    coreutils
    findutils
    gnugrep
    gnused

    bat
    bottom
    cloudflared
    curl
    fd
    fzf
    fnlfmt
    gdb
    git-crypt
    graalvm11-ce
    go
    gopls
    htop
    imagemagick
    jq
    sumneko-lua-language-server
    nodejs
    ripgrep
    rnix-lsp
    rust-analyzer
    rust-bin.stable.latest.default
    rsync
    sqlite
    tree
    tree-sitter
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };


  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    sandbox = false
  '';

  xdg.configFile."i3/config" = {
    source = ../config/i3/config;
  };

}
