{ lib, userConfig, ... }:
{
  # Configure X11
  services.xserver = lib.mkIf userConfig.machineConfig.workstation.enable {
    enable = true;
    xkb = {
      layout = "us";
      variant = ""; # Standard QWERTY
      options = "grp:alt_shift_toggle";
    };

    # Drivers will be detected & set itself
    videoDrivers = [
      "modesetting"
      "fbdev"
    ];
  };
}
