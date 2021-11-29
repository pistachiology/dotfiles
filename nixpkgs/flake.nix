{
  description = "pistachiology flakes file";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = https://github.com/nix-community/home-manager/archive/master.tar.gz;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    {
      homeConfigurations = {
        tua = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "tua";
          homeDirectory = "/home/tua";
          stateVersion = "22.05";
          configuration = { config, pkgs, ... }: {
            imports = [
              ./modules/base.nix
              ./modules/bloop.nix
              ./modules/fish.nix
              ./modules/nvim.nix
              ./modules/tmux.nix
            ];
          };
        };

        nlaoticharoe = home-manager.lib.homeManagerConfiguration
          {
            system = "x86_64-darwin";
            username = "nlaoticharoe";
            homeDirectory = "/Users/nlaoticharoe";
            stateVersion = "22.05";

            configuration = { config, pkgs, ... }: {
              imports = [
                ./modules/base.nix
                ./modules/bloop.nix
                ./modules/fish.nix
                ./modules/nvim.nix
                ./modules/tmux.nix
              ];
            };
          };

      };
    };
}
