{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    lib.mkIf userConfig.machine.workstation [
      (callPackage ./patch { })
    ];
}
