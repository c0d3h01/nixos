{
  config,
  ...
}:

{
  # handle ACPI events
  services.acpid.enable = true;
  hardware.acpilight.enable = false;

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      cpupower
    ];
  };
}
