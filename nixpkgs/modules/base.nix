{ config, pkgs, libs, ... }:
{

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bat
    bottom
    cloudflared
    curl
    fd
    fzf
    git-crypt
    graalvm11-ce
    htop
    imagemagick
    jq
    ripgrep
    rnix-lsp
    rustup
    rust-analyzer
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
}
