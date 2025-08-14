{
  lib,
  config,
  userConfig,
  ...
}:
# https://wiki.debian.org/Suspend#Disable_suspend_and_hibernation
{
  config = lib.mkIf (userConfig.machineConfig.type == "server") {
    services.logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "suspend-then-hibernate";
    };

    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=no
    '';
  };
}
