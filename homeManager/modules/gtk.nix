{
  lib,
  userConfig,
  pkgs,
  ...
}:

{
  config = lib.mkIf userConfig.machine.workstation {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # GTK theming
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-Dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
