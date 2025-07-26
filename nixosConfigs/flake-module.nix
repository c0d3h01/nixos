{ inputs, ... }:
let
  hosts = import ../lib/hosts.nix;

  # Function to create a NixOS configuration for a host
  mkNixosSystem =
    hostName: userConfig:
    inputs.nixpkgs.lib.nixosSystem {
      inherit (userConfig) system;
      specialArgs = {
        inherit inputs userConfig hostName;
        inherit (inputs) self;
      };
      modules = [
        # Home Manager integration
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs userConfig hostName;
              inherit (inputs) self;
            };
            users.${userConfig.username} = {
              imports = [ ../homeManager/modules ];
            };
          };
        }
      ];
    };

  # Generate nixosConfigurations for all hosts
  nixosConfigurations = inputs.nixpkgs.lib.mapAttrs mkNixosSystem hosts;
in
{
  flake = { inherit nixosConfigurations; };
}
