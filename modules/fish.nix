{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];

    shellInit = ''
      source ${config.xdg.configHome}/myfish/config.fish
    '';

    interactiveShellInit = ''
      source ${config.xdg.configHome}/myfish/theme.fish
    '';

    shellAbbrs = {
      j = "just";
      n = "nvim";
      vim = "nvim";
      gst = "git status";
      gco = "git checkout";
      gr = "git rebase -i";
      grd = "git rebase -i develop";
      grm = "git rebase -i master";
      gr2 = "git rebase -i @~2";
      kns = "kubectl config view --minify -o jsonpath='{..namespace}'";
    };
  };


  xdg.configFile.myfish = {
    source = ../config/fish;
    recursive = true;
  };
}
