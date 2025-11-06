{
  userConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals;
  isWorkstation = userConfig.machineConfig.workstation.enable;
in
{
  imports = [
    ./git
    ./programs
    ./shells
    ./system
    ./terminal
    ./variables.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
    packages =
      with pkgs;
      optionals isWorkstation [
        notion-app-enhanced
      ];
  };
}
