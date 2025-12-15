{
  lib,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = false;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL for parallel compute
    ];
  };

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "gpl";
  };

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu.opencl.enable = true;
}
