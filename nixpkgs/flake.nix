{
  description = "pistachiology flakes file";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = https://github.com/nix-community/home-manager/archive/master.tar.gz;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      overlays = [
        (final: prev: {
          bloop = prev.bloop.overrideAttrs (old: rec {
            version = "1.4.11";
          });
        })
      ];
    in
    {
      homeConfigurations = {
        tua = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "tua";
          homeDirectory = "/home/tua";
          stateVersion = "22.05";
          configuration = { config, pkgs, ... }: {
            imports = [
              ./modules/fish.nix
              ./modules/nvim.nix
            ];

            nixpkgs.overlays = overlays;

            home.packages = with pkgs; [
              bat
              curl
              htop
              fd
              rnix-lsp
              fzf
              imagemagick
              jq
              ripgrep
              sqlite
              tree
              tree-sitter
              hostname
            ];

            # Let Home Manager install and manage itself.
            programs = {
              home-manager.enable = true;

              zoxide = {
                enable = true;
                enableFishIntegration = true;
              };
            };


            xdg.configFile."nix/nix.conf".text = ''
              experimental-features = nix-command flakes
              sandbox = false
            '';
          };
        };

        nlaoticharoe = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          username = "nlaoticharoe";
          homeDirectory = "/Users/nlaoticharoe";
          stateVersion = "22.05";

          configuration = { config, pkgs, ... }: {
            imports = [
              ./modules/fish.nix
              ./modules/nvim.nix
            ];

            nixpkgs.overlays = overlays;

            home.packages = with pkgs; [
              bat
              bottom
              bloop
              curl
              htop
              rnix-lsp
              fd
              fzf
              imagemagick
              jq
              ripgrep
              sqlite
              tree
              tree-sitter
              graalvm11-ce
            ];

            # Let Home Manager install and manage itself.
            programs = {
              home-manager.enable = true;

              zoxide = {
                enable = true;
                enableFishIntegration = true;
              };
            };

            xdg.configFile."nix/nix.conf".text = ''
              experimental-features = nix-command flakes
              sandbox = false
            '';
          };
        };


      };
    };
}
