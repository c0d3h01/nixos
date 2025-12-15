{ config, lib, pkgs, ... }:

let
  rootFs = config.fileSystems."/".fsType;
  isXfs = rootFs == "xfs";
in {
  # XFS-specific optimizations
  environment.systemPackages = lib.mkIf isXfs [ pkgs.xfsprogs ];

  # Filesystem integrity: weekly scrub for both NVMe + HDD
  systemd.services.filesystem-scrub = lib.mkIf isXfs {
    description = "XFS filesystem scrub for data integrity";
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      IOSchedulingClass = "idle";
      ExecStart = "${pkgs.xfsprogs}/bin/xfs_scrub -v /";
    };
  };

  systemd.timers.filesystem-scrub = lib.mkIf isXfs {
    enable = true;
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
