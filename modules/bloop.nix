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

  bleep = with pkgs; stdenv.mkDerivation rec {
    version = "0.0.1-M21";
    name = "bleep";
    platform =
      if stdenv.isLinux && stdenv.isx86_64 then "x86_64-pc-linux"
      else if stdenv.isDarwin && stdenv.isx86_64 then "x86_64-apple-darwin"
      else throw "unsupported platform";

    src = fetchTarball {
      url = "https://github.com/oyvindberg/bleep/releases/download/v${version}/bleep-${platform}.tar.gz";
      sha256 =
        if stdenv.isLinux && stdenv.isx86_64 then "sha256:0nzm0xmcaz11nvcm2ax7q612z5lhq3crqrmf5riscmcg1vn4ynnm"
        else if stdenv.isDarwin && stdenv.isx86_64 then "1a3a90ggyhfjq58wiqlxhz4djjp5crxvl822f8gzm3pjara5xpbc"
        else throw "unsupported platform";
    };

    dontUnpack = true;
    buildInputs = [ stdenv.cc.cc.lib zlib ];
    nativeBuildInputs = [ installShellFiles makeWrapper ]
      ++ lib.optional stdenv.isLinux autoPatchelfHook;

    installPhase = ''
      runHook preInstall
      install -D -m 0755 ${src} $out/.bleep-wrapped
      makeWrapper $out/.bleep-wrapped $out/bin/bleep
      runHook postInstall
    '';
  };
in
{
  home.packages = with pkgs; [ bloop bleep ];
  /* nixpkgs.overlays = overlays; */
}
