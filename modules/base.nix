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
    comma
    curl
    fd
    fnlfmt
    fzf
    gdb
    git-crypt
    go
    gopls
    graalvm11-ce
    htop
    imagemagick
    jq
    nix-doc
    nodejs
    ripgrep
    rnix-lsp
    rsync
    rust-analyzer
    rust-bin.stable.latest.default
    sqlite
    sumneko-lua-language-server
    tree
    tree-sitter
    unzip
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


  nix = {
    settings = {
      sandbox = false;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
