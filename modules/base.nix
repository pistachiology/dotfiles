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
  /* nixpkgs.config.allowUnfree = true; */
  nixpkgs.overlays = overlays;

  home.packages = with pkgs; [
    # GNU stuffs for better cli experience
    coreutils
    findutils
    gnugrep
    gnused

    bat
    bear
    bottom
    # clangd - better use native clangd from os.
    cloudflared
    comma
    curl
    ccls
    # eza
    sccache
    fd
    fnlfmt
    fzf
    git-crypt
    go
    gopls
    gdb
    openjdk8
    htop
    imagemagick
    jq
    kotlin-language-server
    nix-doc
    nodejs
    nodejs-18_x
    marksman
    ripgrep
    rnix-lsp
    rsync
    rustup
    pyright
    /* rust-bin.stable.latest.default */
    sqlite
    sumneko-lua-language-server
    socat
    netcat
    tree
    tree-sitter
    unzip

    openssh
    nodePackages.typescript-language-server
    nodePackages.eslint
    nodePackages.aws-cdk
    zk
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
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

}
