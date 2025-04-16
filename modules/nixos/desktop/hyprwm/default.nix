{
  config,
  pkgs,
  userConfig,
  inputs,
  ...
}:
{
  imports = [
    ./electron.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./xdg.nix
  ];

  home-manager.users.${userConfig.username} = _: {
    home.file = {
      ".scripts/autostart.sh" = {
        source = ./autostart.sh;
        executable = true;
      };
    };
  };

  environment = {
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  programs.dconf.enable = true;
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to Wonderland' --asterisks --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = userConfig.username;
      };
    };
  };
}
