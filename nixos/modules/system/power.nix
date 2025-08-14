{
  lib,
  userConfig,
  ...
}:
let
  cfg = userConfig.machineConfig;
  islaptop = cfg.type == "laptop";
in
{
  config = lib.mkIf (islaptop && cfg.workstation.enable) {
    # Power management
    services.power-profiles-daemon.enable = false;

    # Auto CPU frequency scaling for laptops
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "schedutil";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
