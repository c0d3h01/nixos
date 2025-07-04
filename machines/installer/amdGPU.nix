{
  hardware = {
    graphics.enable32Bit = true;
    amdgpu = {
      opencl.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
  };
}
