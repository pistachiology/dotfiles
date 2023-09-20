{ config, pkgs, libs, ... }:
{
  xdg.configFile = {
    "yabai" = {
      source = ../config/yabai;
      recursive = true;
    };

    "skhd" = {
      source = ../config/skhd;
      recursive = true;
    };
  };


  # bind skhd to bin path. this is required
  home.packages = with pkgs; [
    skhd
  ];
}
