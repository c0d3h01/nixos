{ userConfig, lib, ... }:
{
  # AI and ML services
  services.ollama = {
    enable = true;
    # Set appropriate acceleration based on GPU type
    acceleration =
      if userConfig.machine.gpuType == "nvidia" then
        "cuda"
      else if userConfig.machine.gpuType == "amd" then
        "rocm"
      else
        null; # No acceleration for Intel or other GPUs
  };
}
