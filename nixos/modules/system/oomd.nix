{ lib, ... }:
{
  systemd = {
    # Systemd OOMd
    oomd = {
      enable = lib.mkDefault true;
      enableRootSlice = true;
      enableUserSlices = true;
      enableSystemSlice = true;
      extraConfig.DefaultMemoryPressureDurationSec = "20s";
    };

    services.nix-daemon.serviceConfig.OOMScoreAdjust = lib.mkDefault 350;

    tmpfiles.settings."10-oomd-root".w = {
      # Enables storing of the kernel log (including stack trace) into pstore upon a panic or crash.
      "/sys/module/kernel/parameters/crash_kexec_post_notifiers" = {
        age = "-";
        argument = "Y";
      };

      # Enables storing of the kernel log upon a normal shutdown (shutdown, reboot, halt).
      "/sys/module/printk/parameters/always_kmsg_dump" = {
        age = "-";
        argument = "N";
      };
    };
  };
}
