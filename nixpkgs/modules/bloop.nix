{ config, pkgs, libs, ... }:

let
  fetchurl = pkgs.fetchurl;
  stdenv = pkgs.stdenv;
  coursier = pkgs.coursier;
  overlays = [
    (final: prev: {
      bloop = prev.bloop.overrideAttrs (old: rec {
        version = "1.4.11";
        bloop-coursier-channel = fetchurl {
          url = "https://github.com/scalacenter/bloop/releases/download/v1.4.11/bloop-coursier.json";
          sha256 = "0h8gw1sgn7zgn5a2cfd95aiy1iw918vmi9i5xpss5390g3b7z08a";
        };
      });
    })
  ];
in
{
  home.packages = with pkgs; [ bloop ];
  nixpkgs.overlays = overlays;
}
