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
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
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
    };
  };


  xdg.configFile.myfish = {
    source = ../config/fish;
    recursive = true;
  };
}
