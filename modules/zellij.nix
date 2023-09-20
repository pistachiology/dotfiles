{ config, pkgs, libs, lib, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile."zellij" = {
    source = ../config/zellij;
    recursive = true;
  };
}
