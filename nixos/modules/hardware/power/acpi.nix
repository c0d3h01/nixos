{
  lib,
  pkgs,
  config,
  userConfig,
  ...
}:
let
  inherit (lib) mkIf;
  isLaptop = userConfig.machineConfig.laptop.enable;
in
{
  config = mkIf isLaptop {
    # handle ACPI events
    services.acpid.enable = true;
    hardware.acpilight.enable = true;

    environment.systemPackages = with pkgs; [
      acpi
      powertop
    ];

    boot = {
      kernelModules = [ "acpi_call" ];
      kernelParams = [ "acpi_backlight=native" ];
      extraModulePackages = with config.boot.kernelPackages; [
        acpi_call
        cpupower
      ];
    };
  };
}
