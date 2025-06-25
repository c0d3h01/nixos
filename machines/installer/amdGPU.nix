{
  hardware.graphics.enable32Bit = true;

  hardware.amdgpu = {
    opencl.enable = true;

    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
