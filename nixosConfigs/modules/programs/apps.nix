{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
{
  # System programs - only enable if GUI is available
  programs = lib.mkIf userConfig.machine.hasGUI {
    firefox.enable = true;

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
  };

  # Environment packages - only install if GUI is available
  environment.systemPackages = lib.mkIf userConfig.machine.hasGUI (
    with pkgs;
    [
      # Development tools
      vscode-fhs
      jetbrains.webstorm
      jetbrains.pycharm-community-bin
      postman
      github-desktop
      drawio

      # Communication apps
      slack
      vesktop # Better Discord client
      telegram-desktop
      zoom-us
      element-desktop # Matrix client
      signal-desktop

      # Productivity apps
      libreoffice-qt6-fresh
      obsidian

      # Media and content creation
      obs-studio
      gimp # Image editing
      vlc # Media player

      # System utilities
      anydesk # Remote desktop
      qbittorrent # Torrent client

      # Finance
      electrum # Bitcoin wallet
    ]
    ++ lib.optionals (userConfig.machine ? gaming && userConfig.machine.gaming) [
      # Gaming (conditional)
      lutris
      heroic
      mangohud
    ]
    ++ lib.optionals (userConfig.dev ? wine && userConfig.dev.wine) [
      # Wine for Windows applications
      wineWowPackages.stable
      winetricks
    ]
  );
}
