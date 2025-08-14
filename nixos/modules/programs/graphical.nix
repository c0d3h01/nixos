{
  lib,
  userConfig,
  config,
  ...
}:
{
  config = lib.mkIf userConfig.machineConfig.workstation.enable {
    programs = {
      # we need dconf to interact with gtk
      dconf.enable = true;

      # gnome's keyring manager
      seahorse.enable = true;
    };
  };
}
