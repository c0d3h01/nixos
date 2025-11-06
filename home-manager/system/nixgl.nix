{
  config,
  pkgs,
  nixgl,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.lib.nixGL) wrap;
in
{
  options.programs.custom.glApps.enable = mkEnableOption "Enable GL wrapped apps";

  config = mkIf config.programs.custom.glApps.enable {
    # NixGL configuration for GPU support
    nixGL = {
      vulkan.enable = true;
      inherit (nixgl) packages;
      defaultWrapper = "mesaPrime";
      offloadWrapper = "mesaPrime";
      installScripts = [ "mesaPrime" ];
    };

    # Desktop applications with GL support
    home.packages = with wrap pkgs; [
      # vscode
    ];
  };
}
