{
  config,
  userConfig,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf userConfig.machineConfig.workstation.enable {
    services = {
      dbus = {
        enable = lib.mkForce true;
        implementation = "broker";
        packages = with pkgs; [
          dconf
          gcr_4
          udisks2
        ];
      };
    };
  };
}
