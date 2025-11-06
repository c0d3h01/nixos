{
  config,
  lib,
  pkgs,
  userConfig,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = userConfig.machineConfig.gpuType;
  isWorskstaion = userConfig.machineConfig.workstation.enable;
in
{
  config = mkIf (cfg == "amd") {

    # xorg drivers
    services.xserver.videoDrivers = [ "amdgpu" ];

    # auto-epp for amd active pstate.
    services.auto-epp.enable = true;

    hardware.graphics = lib.mkIf isWorskstaion {
      enable = true;

      extraPackages = with pkgs; [
        mesa
        libvdpau-va-gl
        libva-vdpau-driver
        # OpenCL support
        rocmPackages.clr.icd
      ];

      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa
        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };

    # Environment variables for optimal GPU performance
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
      AMD_VULKAN_ICD = "RADV";
    };
  };
}
