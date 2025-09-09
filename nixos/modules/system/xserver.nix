{
  lib,
  userConfig,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  iftrue = userConfig.machineConfig.workstation.enable;
in
{
  services.xserver = mkIf iftrue {
    enable = false;
    desktopManager.xterm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };
}
