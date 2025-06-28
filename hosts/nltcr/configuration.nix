{ pkgs, lib, ... }:
{
  users.users.nltcr = {
    name = "nltcr";
    home = "/Users/nltcr";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  # environment.loginShell = "${pkgs.fish}/bin/fish -l";
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  system.stateVersion = 5;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  system.defaults.spaces.spans-displays = true;
  system.defaults.dock.expose-group-by-app = true;
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;

  # Turn off - auto rearrange space 
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.autohide = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = false
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;


  /* services.yabai.enable = true;
  services.yabai.package = pkgs.yabai;
  services.skhd.enable = true; */

  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    terminal-notifier
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    taps = [
      "homebrew/cask"
    ];
    brews = [
      "graphviz"
      "imageoptim-cli"
    ];
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "kitty"
      "alfred"
      "obsidian"
      "logseq"
      "intellij-idea"
      "xquartz"
      "imageoptim"
      "nikitabobko/tap/aerospace"
      "ghostty"
    ];
  };
  ids.uids.nixbld = 19999999;

  programs.nix-index.enable = false;

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  # system.defaults.universalaccess.reduceMotion = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

}
