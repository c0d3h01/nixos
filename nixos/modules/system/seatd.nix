{ userConfig, lib, ... }:
{
  services.seatd = {
    inherit (userConfig.machineConfig.workstation) enable;
  };
}
