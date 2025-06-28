{
  config,
  pkgs,
  libs,
  lib,
  ...
}:
{
  /*
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
      # skhd
    ];
  */

  xdg.configFile = {
    "aerospace" = {
      source = ../config/aerospace;
      recursive = true;
    };

    "ghostty/config" = {
      text = ''
        font-family = "PragmataPro Mono Liga"
        shell-integration = "fish"
        macos-titlebar-style = "tabs"
        macos-non-native-fullscreen = true
        window-save-state = never
      '';
    };
  };

  home.file.".local/bin/aeroswitch" = {
    executable = true;
    text = "#!/bin/bash

if ls -al ~/.config/aerospace/aerospace.toml | grep -q 'default.toml'; then
    ln -sf ~/.config/aerospace/aerospace-qmk.toml ~/.config/aerospace/aerospace.toml
else
    ln -sf ~/.config/aerospace/aerospace-default.toml ~/.config/aerospace/aerospace.toml
fi

aerospace reload-config
";
  };

  home.file.".local/bin/aerocurrent" = {
    executable = true;
    text = "#!/bin/bash

ls -al ~/.config/aerospace/aerospace.toml
";
  };

  home.activation = {
    activateAeroswitch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sf ~/.config/aerospace/aerospace-default.toml ~/.config/aerospace/aerospace.toml
    '';
  };
}
