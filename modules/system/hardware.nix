{ pkgs, ... }:
{
  # ZRAM Swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  # Process Prioritization
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };
}
