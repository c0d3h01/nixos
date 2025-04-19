{
  config,
  pkgs,
  userConfig,
  inputs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./xdg.nix
  ];

  home-manager.users.${userConfig.username} = _: {
    home.file = {
      ".scripts/autostart.sh" = {
        source = ./config/scripts/autostart.sh;
        executable = true;
      };
    };
  };

  environment = {
    # For Electron apps to use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      inputs.hyprpanel.packages.${pkgs.system}.hyprpanel
      brightnessctl
      grim
      gthumb
      hyprpanel
      hyprpaper
      libnotify
      nemo-with-extensions
      networkmanagerapplet
      pavucontrol
      playerctl
      pywal
      slurp
      wl-clipboard
      zenity
    ];
  };

  programs = {
    uwsm.enable = true;
    hyprlock.enable = true;
    dconf.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
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

  services = {
    power-profiles-daemon.enable = true;
    gnome.gnome-keyring.enable = true;
    upower.enable = true;
    blueman.enable = true;

    greetd = {
      enable = true;
      restart = false;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to Wonderland' --asterisks --cmd 'uwsm start hyprland-uwsm.desktop'";
          user = userConfig.username;
        };
      };
    };
  };
}
