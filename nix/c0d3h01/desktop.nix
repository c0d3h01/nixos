{ config, pkgs, ... }:

{
  # Enable X server and GNOME
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.xkb.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable dconf service for GNOME settings management
  programs.dconf.enable = true;

  # Virtual boxes
  virtualisation.libvirtd.enable = true;

  # Exclude unwanted GNOME packages
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-disk-utility
    gnome-backgrounds
    gnome-font-viewer
    gnome-music
    gedit
    epiphany
    geary
    yelp
    baobab
    gnome-console
    gnome-weather
    gnome-text-editor
    gnome-connections
    gnome-contacts
    gnome-system-monitor
    gnome-initial-setup
  ];

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Additional system packages
  environment.systemPackages = with pkgs; [
    gnome-photos
    gnome-tweaks
    gnome-boxes
    evolutionWithPlugins
    rhythmbox
    libreoffice
    micro

    # Gnome Extensions
    gnomeExtensions.user-themes
    gnomeExtensions.gsconnect
  ];

  # Home Manager settings (for per-user configuration)
  home-manager.users.c0d3h01 = { pkgs, ... }: {
    # GNOME dconf settings (User-specific)
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];

        #   favorite-apps = [
        #     "firefox.desktop"
        #     "youtube-music.desktop"
        #     "gnome-text-editor.desktop"
        #     "jupyterlab.desktop"
        #     "element-desktop.desktop"
        #     "vesktop.desktop"
        #     "code.desktop"
        #     "kitty.desktop"
        #     "org.gnome.Nautilus.desktop"
        #   ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
        picture-uri-dark = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${config.users.users.c0d3h01.home}/dotfiles/assets/wallpaper.png";
        primary-color = "#3465a4";
        secondary-color = "#000000";
      };
    };
  };
}
