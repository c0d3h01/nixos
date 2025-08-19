{
  pkgs,
  userConfig,
  lib,
  ...
}:

{
  services.scx = lib.mkIf userConfig.machineConfig.workstation.enable {
    enable = true;
    scheduler = "scx_rustland";
    package = pkgs.scx.rustscheds;
  };
}
