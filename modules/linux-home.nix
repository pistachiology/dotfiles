{ config, pkgs, libs, ... }:
{
  # bind skhd to bin path. this is required
  home.packages = with pkgs; [
    mitmproxy
    proxychains-ng
  ];
}
