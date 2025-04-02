{
  description = "NixOS configuration for c0d3h01";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... } @ inputs:
    let
      user = {
        username = "c0d3h01";
        fullName = "Harshal Sawant";
        email = "c0d3h01@gmail.com";
        hostname = "NixOS";
        stateVersion = "24.11";
      };

      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Create package set with overlays for each system
      pkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlays.default
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            myPackages = prev.callPackage ./pkgs { };
          })
        ];
      };

      # Shared arguments for all modules
      commonArgs = system: {
        inherit inputs system user agenix;
        pkgs = pkgsFor system;
        lib = nixpkgs.lib;
      };
    in
    {
      # Main NixOS system configuration
      nixosConfigurations.${user.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = commonArgs "x86_64-linux";
        modules = [
          ./hosts/${user.username}
          inputs.spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = commonArgs "x86_64-linux";
              users.${user.username} = {
                imports = [ ./home ];
                home.stateVersion = user.stateVersion;
              };
            };
          }
        ];
      };

      # Development and CI environments
      devShells = forAllSystems (system:
        let pkgs = pkgsFor system; in {
          default = pkgs.mkShell {
            packages = with pkgs; [ pkg-config gtk3 ];
            shellHook = "exec zsh";
          };

          ci = pkgs.mkShell {
            packages = with pkgs; [ nixpkgs-fmt statix deadnix ];
          };
        });

      # Formatting and linting configuration
      formatter = forAllSystems (system: (pkgsFor system).nixpkgs-fmt);

      checks = forAllSystems (system: {
        pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
        };
      });
    };
}
