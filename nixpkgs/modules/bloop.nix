{ config, autoPatchelfHook, pkgs, libs, lib, ... }:

let
  fetchurl = pkgs.fetchurl;
  stdenv = pkgs.stdenv;
  coursier = pkgs.coursier;
  overlays = [
    (final: prev: {
      bloop = prev.bloop.overrideAttrs
        (old: rec {
          # patch until unstable version are release
          nativeBuildInputs = [ pkgs.installShellFiles pkgs.makeWrapper ] ++ lib.optional stdenv.isLinux autoPatchelfHook;
        });
    })
  ];
in
{
  home.packages = with pkgs; [ bloop ];
  nixpkgs.overlays = overlays;
}
