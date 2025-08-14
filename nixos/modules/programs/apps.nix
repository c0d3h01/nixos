{
  pkgs,
  config,
  lib,
  userConfig,
  ...
}:
{
  config = lib.mkIf userConfig.machineConfig.workstation.enable {
    # Default browser
    programs.firefox.enable = true;

    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
      usbmon.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
        ghostty
        neovim
        android-studio
        vscode-fhs
        jetbrains.webstorm
        jetbrains.pycharm-community-bin
        postman
        github-desktop
        drawio
        slack
        vesktop
        telegram-desktop
        zoom-us
        element-desktop
        signal-desktop
        libreoffice
        obsidian
        gimp
        anydesk
        qbittorrent
        electrum
        arduino
      ]
      ++ lib.optionals userConfig.devStack.wine.enable [
        wineWowPackages.stable
        winetricks
      ];
  };
}
