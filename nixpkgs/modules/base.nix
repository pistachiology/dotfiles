{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    bat
    bottom
    curl
    fd
    fzf
    graalvm11-ce
    git-crypt
    htop
    imagemagick
    jq
    ripgrep
    rnix-lsp
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
