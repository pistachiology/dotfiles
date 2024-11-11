{ config, pkgs, libs, ... }:
{
  # bind skhd to bin path. this is required
  home.packages = let 
      pkg = with pkgs; [ mitmproxy proxychains-ng ];
      pythonPackage = with pkgs.python3.pkgs; [ mitmproxy ];
  in pkg ++ pythonPackage;
}
