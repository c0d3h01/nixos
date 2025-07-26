{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.programs.nm-here.enable = mkEnableOption "";

  config = mkIf config.programs.nm-here.enable {
  };
}
