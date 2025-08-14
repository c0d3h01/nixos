{
  lib,
  pkgs,
  config,
  userConfig,
  ...
}:

{
  xdg.portal = lib.mkIf userConfig.machineConfig.workstation.enable {
    enable = true;
    xdgOpenUsePortal = true;

    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 60;
          chooser_type = "simple";
          chooser_cmd = "${lib.getExe pkgs.slurp} -f %o -or";
        };
      };
    };
  };
}
