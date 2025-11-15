{
  config,
  userConfig,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = userConfig.machineConfig;
in
{
  config = mkIf cfg.glApps {
    # nix-gl-host configuration for GPU support
    nixGL.packages = lib.nixGL.auto.nixGLDefault;
    nixGL.defaultWrapper = "mesa";
    nixGL.installScripts = [ "mesa" ];
  };
}