{
  description = "pistachiology flakes file";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, rust-overlay, home-manager, ... }:
    let
      overlays = [ rust-overlay.overlays.default ];
    in
    {
      nixosConfigurations = {
        qweeeee = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit (nixpkgs); };
          modules = [
            ./hosts/qweeeee/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;

                users.tua = {
                  nixpkgs.overlays = overlays;
                  imports = [
                    {
                      home.stateVersion = "22.11";
                      home.username = "tua";
                      home.homeDirectory = "/home/tua";

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
                    ./modules/kitty.nix
                    ./modules/linux.nix
                    ./modules/mail.nix
                    ./modules/neomutt.nix
                    ./modules/neovim.nix
                    ./modules/pass.nix
                    ./modules/ranger.nix
                    ./modules/tmux.nix
                  ];
                };
              };
            }
          ];
        };
      };

      homeConfigurations = {
        pistachio = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;

          modules = [
            ({ pkgs, ... }: {
              home.username = "pistachio";
              home.homeDirectory = "/Users/pistachio";
              home.stateVersion = "22.11";
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
              nix.package = pkgs.nix;

              programs.git = {
                userName = "pistachiology";
                userEmail = "im@itua.dev";
                signing = {
                  key = "1BF3F801844B853E9665C5C18534BC47EFCB2FBB";
                  signByDefault = true;
                };
              };
            })
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
            ({ pkgs, ... }: {
              home.username = "nlaoticharoe";
              home.homeDirectory = "/Users/nlaoticharoe";
              home.stateVersion = "22.11";
              nix.package = pkgs.nix;
              nixpkgs.overlays = overlays;
              programs.git.signing = {
                key = "55676A6212EBDA01EF16B79B27A1B1AE3F53C840";
                signByDefault = true;
              };
            })
            ./modules/ranger.nix
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
