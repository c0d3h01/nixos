{
  config,
  pkgs,
  userConfig,
  ...
}:
{

  # Enable X server and GNOME
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];
      displayManager.gdm.enable = true;
    };
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.indexOf("org.freedesktop.udisks2.filesystem-mount") == 0 &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';

  # Exclude unwanted GNOME packages
  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-backgrounds
      gnome-font-viewer
      epiphany
      yelp
      baobab
      gnome-weather
      gnome-text-editor
      gnome-connections
      gnome-music
      gnome-remote-desktop
      gnome-usage
      gnome-contacts
      gnome-system-monitor
    ];

    systemPackages = with pkgs; [
      # Desktop common utils here
      gnome-photos
      gnome-tweaks
      libreoffice
      rhythmbox
      qbittorrent

      # Gnome extensions here
      gnomeExtensions.gsconnect
      gnomeExtensions.dash-to-dock
    ];

    pathsToLink = [
      "/share/icons"
      "/share/applications"
    ];
  };
}
