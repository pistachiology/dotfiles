{ config, pkgs, libs, ... }:
{
  home.file.".xinitrc".source = ./../config/xinitrc;

  home.packages = with pkgs; [
    # required
    (rofi.override { plugins = [ rofi-emoji rofi-calc ]; })
    rofi-calc
    rofi-emoji
    kitty
    xsel
    pavucontrol
    _1password-gui
    _1password

    # desktop
    firefox
    brave
    tdesktop
    discord

    # misc
    OSCAR
  ];

  services.dunst = {
    enable = true;
  };

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
