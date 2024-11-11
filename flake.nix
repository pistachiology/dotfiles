{
  description = "pistachiology flakes file";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    /* mach-nix.url = "mach-nix/3.5.0"; */


    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, darwin, nixpkgs, nixpkgs-unstable, rust-overlay, home-manager, mach-nix, ... }:
    let
      overlays = [ rust-overlay.overlays.default ];
    in
    {
      nixosConfigurations = {
        qweeeee = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            specialArgs = { inherit (nixpkgs); };
            modules = [
              ./hosts/qweeeee/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager =
                  {
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

      darwinConfigurations = rec {
        nltcr = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = rec {
            inherit inputs;
          };
          modules = [
            # Main `nix-darwin` config
            ./hosts/nltcr/configuration.nix
            # `home-manager` module
            home-manager.darwinModules.home-manager
            {
              # `home-manager` config
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = rec {
                pkgs-unstable = import nixpkgs-unstable {
                  system = "aarch64-darwin";
                };
              };
              home-manager.users.nltcr = {
                nixpkgs.overlays = overlays;

                imports = [
                  {
                    home.stateVersion = "22.11";
                    home.username = "nltcr";
                    home.homeDirectory = "/Users/nltcr";
                  }
                  ./modules/base.nix
                  ./modules/darwin.nix
                  ./modules/fish.nix
                  ./modules/git.nix
                  ./modules/kitty.nix
                  ./modules/neovim.nix
                  ./modules/tmux.nix
                ];
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
      };
    };
}
