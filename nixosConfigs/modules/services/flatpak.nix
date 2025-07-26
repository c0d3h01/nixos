{
  lib,
  userConfig,
  ...
}:
{
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = lib.mkIf userConfig.machine.hasGUI true;
  environment.sessionVariables = lib.mkIf userConfig.machine.hasGUI {
    XDG_DATA_DIRS = [ "/var/lib/flatpak/exports/share" ];
  };
}
