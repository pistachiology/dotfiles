{ config, pkgs, libs, ... }:
{

  nixpkgs.config.allowUnfree = true;
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
    
    fennel
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
