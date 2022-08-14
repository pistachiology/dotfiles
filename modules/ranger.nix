{ config, pkgs, libs, lib, ... }:
{
  home.packages = with pkgs; [ ranger ];

  xdg.configFile."ranger/rc.conf".text = ''
    set preview_images true
    set preview_images_method kitty

    map <C-d> shell dragon -a -x %p
  '';

}
