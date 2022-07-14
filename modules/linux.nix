{ config, pkgs, libs, ... }:
{
  home.file.".xinitrc".source = ./../config/xinitrc;

  home.packages = with pkgs; [
    rofi-calc
    /* OSCAR */
  ];

  xdg.configFile = {
    "rofi" = {
      source = ../config/rofi;
      recursive = true;
    };

    "polybar" = {
      source = ../config/polybar;
      recursive = true;
    };

    "i3" = {
      source = ../config/i3;
      recursive = true;
    };

    "dunst" = {
      source = ../config/dunst;
      recursive = true;
    };
  };

}
