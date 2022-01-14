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
    git-crypt
    graalvm11-ce
    htop
    imagemagick
    jq
    /* sumneko-lua-language-server # broken on mac os https://github.com/NixOS/nixpkgs/issues/153804 */
    nodejs
    ripgrep
    rnix-lsp
    rust-analyzer
    rust-bin.stable.latest.default
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
