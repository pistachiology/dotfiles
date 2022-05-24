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
}
