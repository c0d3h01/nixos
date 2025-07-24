{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.lib.nixGL) wrap;
in
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    package = wrap pkgs.wezterm;
  };
  xdg.configFile."wezterm" = {
    source = ./cfg;
    recursive = true;
  };
}
