{ inputs, ... }:
let
  system = "x86_64-linux";
  username = "c0d3h01";
  hostname = "fedora";
  homeModule = ./modules;
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."${username}@${hostname}" =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs username hostname;
          inherit (inputs) self;
          inherit (inputs) nixgl;
        };
        modules = [ homeModule ];
      };
}
