{
  config,
  userConfig,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gnome-photos
    gnome-tweaks
    libreoffice
    rhythmbox
    qbittorrent
    gnomeExtensions.gsconnect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "dash-to-dock@micxgx.gmail.com"
        "just-perfection-desktop@just-perfection"
      ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      theme = true;
      custom-shell-theme = true;
    };
    # interface
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      clock-show-weekday = true;
      clock-show-seconds = false;
      clock-show-date = true;
      clock-format = "12h";
      color-scheme = "prefer-dark";
    };
    # power management
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 1800;
      power-button-action = "poweroff";
    };
    # night light
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = 4000;
    };
    # keyboard
    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
      remember-numlock-state = true;
    };
    # touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
    };
    # workspaces
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };
    # wallpaper
    "org/gnome/desktop/background" = {
      picture-uri = "file://${config.home.homeDirectory}/dotfiles/assets/wallpapers/image1.png";
      picture-uri-dark = "file://${config.home.homeDirectory}/dotfiles/assets/wallpapers/image1.png";
      picture-options = "zoom";
    };
    # screensaver
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${config.home.homeDirectory}/dotfiles/assets/wallpapers/image1.png";
      picture-options = "zoom";
      primary-color = "#8a0707";
      secondary-color = "#000000";
    };
  };
}
