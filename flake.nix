{
  description = "pistachiology flakes file";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, rust-overlay, home-manager, ... }:
    let
      overlays = [ rust-overlay.overlay ];
    in
    {
      homeConfigurations = {
        tua = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          modules = [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              home.username = "tua";
              home.homeDirectory = "/home/tua";
              home.stateVersion = "22.11";

              programs.git = {
                userName = "pistachiology";
                userEmail = "im@itua.dev";
                signing = {
                  key = "1BF3F801844B853E9665C5C18534BC47EFCB2FBB";
                  signByDefault = true;
                };
              };
            }
            ./modules/base.nix
            ./modules/bloop.nix
            ./modules/fish.nix
            ./modules/git.nix
            ./modules/linux.nix
            ./modules/neovim.nix
            ./modules/kitty.nix
            ./modules/tmux.nix
          ];
        };


        pistachio = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;

          modules = [
            {
              home.username = "pistachio";
              home.homeDirectory = "/Users/pistachio";
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              programs.git = {
                userName = "pistachiology";
                userEmail = "im@itua.dev";
                signing = {
                  key = "1BF3F801844B853E9665C5C18534BC47EFCB2FBB";
                  signByDefault = true;
                };
              };
            }
            ./modules/base.nix
            ./modules/bloop.nix
            ./modules/darwin.nix
            ./modules/fish.nix
            ./modules/git.nix
            ./modules/kitty.nix
            ./modules/neovim.nix
            ./modules/tmux.nix
          ];
        };

        nlaoticharoe = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;

          modules = [
            {
              home.username = "nlaoticharoe";
              home.homeDirectory = "/Users/nlaoticharoe";
              home.stateVersion = "22.11";
              nixpkgs.overlays = overlays;
              programs.git.signing = {
                key = "55676A6212EBDA01EF16B79B27A1B1AE3F53C840";
                signByDefault = true;
              };
            }
            ./modules/base.nix
            ./modules/bloop.nix
            ./modules/darwin.nix
            ./modules/fish.nix
            ./modules/git.nix
            ./modules/kitty.nix
            ./modules/neovim.nix
            ./modules/tmux.nix
            ./secrets/ag.nix
          ];

        };

      };
    };
}
