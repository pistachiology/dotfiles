{ config, pkgs, libs, lib, ... }:
{
  programs.password-store = {
    enable = true;
    settings = { PASSWORD_STORE_DIR = "$HOME/.password-store"; };
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };
}
