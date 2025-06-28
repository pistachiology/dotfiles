{ config, pkgs, libs, ... }:
let
  overlays = [
    (final: prev: {
      discord = prev.discord.overrideAttrs
        (old: rec {
          version = "0.0.19";

          # patch until unstable version are release
          src = pkgs.fetchurl {
            url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
            sha256 = "sha256-GfSyddbGF8WA6JmHo4tUM27cyHV5kRAyrEiZe1jbA5A=";
          };

        });
    })
  ];
in
{
  home.file.".xinitrc".source = ./../config/xinitrc;


  nixpkgs.overlays = overlays;
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
    evince # pdf viewer

    # misc
    flameshot
    libnotify
    OSCAR
    rclone
    xdragon
    file
    lynx
    elinks
  ];

  services.dunst = {
    enable = true;
  };
  services.kdeconnect = {
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "x-scheme-handler/tg" = "telegramdesktop.desktop";

      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "x-scheme-handler/chrome" = "brave-browser.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
    };
  };

  home.file.".local/bin/bootstrap.sh" = {
    source = ../bootstrap.sh;
  };


}
