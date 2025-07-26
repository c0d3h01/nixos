{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  config = mkIf (userConfig.desktop.windowManager == "gnome") {

    services = {
      # GNOME desktop environment configuration
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
        # Disable xterm
        desktopManager.xterm.enable = false;
        excludePackages = [ pkgs.xterm ];
      };

      # Disable gnome initial setup
      gnome.gnome-initial-setup.enable = false;

      # GNOME settings
      gnome.gnome-keyring.enable = true;
      gnome.gnome-remote-desktop.enable = lib.mkForce false;
      gnome.glib-networking.enable = true;
      udev.packages = [ pkgs.gnome-settings-daemon ];
    };

    # Exclude unwanted GNOME packages
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-font-viewer
      epiphany
      yelp
      baobab
      gnome-music
      gnome-remote-desktop
      gnome-usage
      gnome-console
      gnome-contacts
      gnome-weather
      gnome-maps
      gnome-connections
      gnome-system-monitor
      gnome-user-docs
    ];
  };
}
