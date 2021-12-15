{
  description = "pistachiology flakes file";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
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

            programs.git = {
              userName = "pistachiology";
              userEmail = "im@itua.dev";
              signing = {
                key = "1BF3F801844B853E9665C5C18534BC47EFCB2FBB";
                signByDefault = true;
              };
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
                ./modules/git.nix
                ./secrets/ag.nix
              ];

              programs.git.signing = {
                key = "55676A6212EBDA01EF16B79B27A1B1AE3F53C840";
                signByDefault = true;
              };
            };
          };

      };
    };
}
