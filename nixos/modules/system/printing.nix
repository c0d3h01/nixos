{
  lib,
  userConfig,
  ...
}:
{
  services = lib.mkIf userConfig.machineConfig.workstation.enable {
    printing = {
      enable = true;
      openFirewall = true;
    };

    # Avahi (mDNS) for network printer discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
    };
  };
}
