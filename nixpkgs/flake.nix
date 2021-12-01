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
              ./modules/git.nix
              ./modules/neovim.nix
              ./modules/tmux.nix
            ];

            programs.git.signing = {
              key = "1BF3F801844B853E9665C5C18534BC47EFCB2FBB";
              signByDefault = true;
            };

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
                ./modules/neovim.nix
                ./modules/tmux.nix
              ];
            };
          };

      };
    };
}
