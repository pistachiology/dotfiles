{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    bat
    bottom
    curl
    htop
    rnix-lsp
    fd
    fzf
    imagemagick
    jq
    ripgrep
    sqlite
    tree
    tree-sitter
    graalvm11-ce
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };


  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    sandbox = false
  '';
}
