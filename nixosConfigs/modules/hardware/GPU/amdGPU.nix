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
in
{
  config = mkIf (cfg == "amd") {
    hardware.graphics = {
      enable = true;

      extraPackages = with pkgs; [
        libva
        libvdpau
        vulkan-tools
        mesa
      ];

      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
        libvdpau
        vulkan-loader
      ];
    };

    # Essential GPU utilities
    environment.systemPackages = with pkgs; [
      glxinfo
      vulkan-tools
      libva-utils
      clinfo
    ];

    boot.kernelParams = [
      # Support for older GCN GPUs (Southern Islands: SI, CIK)
      # Only needed if you have pre-2015 AMD GPUs (e.g., HD 7000, R9 200, etc.)
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
    ];

    # Environment variables
    environment.sessionVariables = {
      # VA-API: Use the Gallium driver (modern) or radeonsi
      # Note: Newer systems use `radeonsi` or `venus` (for AV1), but `radeonsi` is safe default
      LIBVA_DRIVER_NAME = "radeonsi";

      # VDPAU driver selection
      VDPAU_DRIVER = "radeonsi";
    };
  };
}
