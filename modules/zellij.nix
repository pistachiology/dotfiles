{ config, pkgs, libs, lib, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij" = {
    source = ../config/zellij;
    recursive = true;
  };
}
