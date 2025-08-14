{
  lib,
  config,
  userConfig,
  ...
}:

{
  config = lib.mkIf (userConfig.machineConfig.type == "server") {
    # limit systemd journal size
    # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
    services.journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileSize=50M
    '';
  };
}
