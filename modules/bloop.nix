{ config, pkgs, libs, lib, ... }:

let
  fetchurl = pkgs.fetchurl;
  stdenv = pkgs.stdenv;
  coursier = pkgs.coursier;

  overlays = [
    (final: prev: {
      bloop = prev.bloop.overrideAttrs
        (old: rec {
          version = "1.5.4";

          platform = old.platform;

          # patch until unstable version are release
          bloop-binary = fetchurl rec {
            url = "https://github.com/scalacenter/bloop/releases/download/v${version}/bloop-${platform}";
            sha256 =
              if stdenv.isLinux && stdenv.isx86_64 then "0dizvvkr5dw5xb3ggil2c5xi2vfcqyb46kfxnq8whbrq8pis70pi"
              else if stdenv.isDarwin && stdenv.isx86_64 then "1a3a90ggyhfjq58wiqlxhz4djjp5crxvl822f8gzm3pjara5xpbc"
              else throw "unsupported platform";
          };

        });
    })
  ];
in
{
  home.packages = with pkgs; [ bloop ];
  /* nixpkgs.overlays = overlays; */
}
