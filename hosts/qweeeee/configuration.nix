# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
  kdeconnect-port = { from = 1714; to = 1764; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;

  # Use the UEFI boot loader.
  boot.loader.grub.efiSupport = true;
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "qweeeee";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,mnc";
      options = "grp:win_space_toggle, caps:escape";

      extraLayouts.mnc = {
        description = "Manoonchai DVP";
        languages = [ "tha" ];
        symbolsFile = ./../../layouts/Manoonchai-DVP-40p_xkb;
      };
    };

    xrandrHeads = [
      {
        output = "DP-4";
        primary = true;
      }
      {
        output = "HDMI-0";
        primary = false;
        monitorConfig = ''
          Option "Rotate" "left"
        '';
      }
    ];

    videoDrivers = [ "nvidia" ];
  };


  # Enable the GNOME Desktop Environment.
  services.displayManager = {
    gdm.enable = true;
    defaultSession = "none+i3";

    sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset r rate 150 50
    '';
  };

  services.xserver.windowManager.i3 = {
    enable = true;
  };

  services.redshift = {
    enable = true;
  };

  location = {
    latitude = 13.75398;
    longitude = 100.50144;
  };

  security.sudo.wheelNeedsPassword = false;


  # Enable CUPS to print documents.
  # services.prin# ting.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot

    settings.General.Experimental = "true";
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tua = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    git
  ];

  programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;

  networking.nftables.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraUpFlags = [
      "--advertise-routes=192.168.1.156/32"
    ];

  };

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # Open ports in the firewall.
  networking.firewall.allowedTCPPortRanges = [ kdeconnect-port ];
  networking.firewall.allowedUDPPortRanges = [ kdeconnect-port ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
  ];

}

