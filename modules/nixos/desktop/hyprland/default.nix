{
  config,
  pkgs,
  inputs,
  ...
}:
let
  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery
    ]
  );
in
{
  environment = {
    # For Electron apps to use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages =
      (with pkgs; [
        # System Packages
        bc
        baobab
        cpufrequtils
        duf
        findutils
        ffmpeg
        glib # for gsettings to work
        gsettings-qt
        killall
        libappindicator
        libnotify
        pciutils
        xdg-user-dirs
        xdg-utils
        (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
        #ranger
        # Hyprland Stuff
        ags # desktop overview
        brightnessctl # for brightness control
        cava
        cliphist
        loupe
        grim
        hypridle
        imagemagick
        jq
        networkmanagerapplet
        nwg-displays
        nwg-look
        nvtopPackages.full
        pamixer
        pavucontrol
        gpu-screen-recorder-gtk
        playerctl
        polkit_gnome
        libsForQt5.qt5ct
        kdePackages.qt6ct
        kdePackages.qtwayland
        kdePackages.qtstyleplugin-kvantum # kvantum
        rofi-wayland
        slurp
        swappy
        swaynotificationcenter
        swww
        wallust
        wl-clipboard
        wlogout
        xarchiver
        yad
        yt-dlp
      ])
      ++ [
        python-packages
      ];
  };

  programs = {
    uwsm.enable = true;
    waybar.enable = true;
    hyprlock.enable = true;
    nm-applet.indicator = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
    ];

    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.portal.FileChooser" = [ "xdg-desktop-portal-gtk" ];
      };
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

  # Services to start
  services = {
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = "c0d3h01";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    libinput.enable = true;
    blueman.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
