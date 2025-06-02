{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

    cursorTheme = lib.mkDefault {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = lib.mkDefault {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    gtk3.extraConfig = lib.mkDefault {
      "gtk-application-prefer-dark-theme" = true;
    };

    gtk4.extraConfig = lib.mkDefault {
      "gtk-application-prefer-dark-theme" = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
