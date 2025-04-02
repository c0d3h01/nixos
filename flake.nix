{
  description = "NixOS configuration for c0d3h01";

  inputs = {
    # Core dependencies
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Security and secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Community packages
    nur = {
      url = "github:nix-community/NUR";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dev tools
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      # System configuration
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      defaultSystem = "x86_64-linux";

      # User configuration
      userConfig = rec {
        username = "c0d3h01";
        fullName = "Harshal Sawant";
        email = "c0d3h01@gmail.com";
        hostname = "NixOS";
        stateVersion = "24.11";
      };

      # Helper functions
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      mkPkgs = system: import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
          inputs.nur.overlays.default
          (final: prev: {
            myPackages = prev.callPackage ./pkgs { };
          })
        ];
      };

      # Common module arguments
      mkSpecialArgs = system: {
        inherit inputs system;
        configLib = import ./lib { lib = nixpkgs.lib; };
        user = userConfig;
        pkgs = mkPkgs system;
      };

      # NixOS module
      mkNixOSConfiguration = { system ? defaultSystem, hostname ? userConfig.hostname }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = mkSpecialArgs system // { agenix = inputs.agenix; };

          modules = [
            ({ config, user, ... }: {
              system.stateVersion = user.stateVersion;
              networking.hostName = hostname;
            })

            ./hosts/${userConfig.username}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = mkSpecialArgs system;
                users.${userConfig.username} = {
                  imports = [ ./home ];
                  home.stateVersion = userConfig.stateVersion;
                };
              };
            }

            inputs.agenix.nixosModules.default
            inputs.spicetify-nix.nixosModules.default
          ];
        };

    in
    {
      # NixOS configurations
      nixosConfigurations = {
        ${userConfig.hostname} = mkNixOSConfiguration { };

        "${userConfig.hostname}-minimal" = mkNixOSConfiguration {
          hostname = "${userConfig.hostname}-minimal";
        };
      };

      # Development shells
      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              pkg-config
              gtk3
            ];

            shellHook = ''
              exec ${pkgs.zsh}/bin/zsh
            '';
          };

          ci = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              statix
              deadnix
            ];
          };
        });

      # Formatter
      formatter = forAllSystems (system: let pkgs = mkPkgs system; in pkgs.nixpkgs-fmt);

      # CI checks
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
