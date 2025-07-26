{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
{
  # Enable OpenGL for graphics applications - only if GUI is available
  hardware.opengl = lib.mkIf userConfig.machine.opengl {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # For 32-bit applications

    # Dynamic packages based on actual GPU type
    extraPackages =
      with pkgs;
      # Intel graphics packages
      lib.optionals (userConfig.machine.gpuType == "intel") [
        intel-media-driver # For newer Intel GPUs (Broadwell+)
        intel-vaapi-driver # VA-API support
        intel-compute-runtime # Intel OpenCL support
      ]
      # AMD graphics packages
      ++ lib.optionals (userConfig.machine.gpuType == "amd") [
        amdvlk # AMD Vulkan driver
        rocmPackages.clr # AMD OpenCL support
        mesa # Mesa drivers for AMD
      ]
      # NVIDIA packages (if needed here, though usually handled in nvidia.nix)
      ++ lib.optionals (userConfig.machine.gpuType == "nvidia") [
        # Usually handled by nvidia.nix, but adding basic support
        mesa
      ];

    # Dynamic 32-bit packages based on GPU type
    extraPackages32 =
      with pkgs.pkgsi686Linux;
      # Intel 32-bit packages
      lib.optionals (userConfig.machine.gpuType == "intel") [
        intel-media-driver
        intel-vaapi-driver
      ]
      # AMD 32-bit packages
      ++ lib.optionals (userConfig.machine.gpuType == "amd") [
        amdvlk
      ];
  };
}
