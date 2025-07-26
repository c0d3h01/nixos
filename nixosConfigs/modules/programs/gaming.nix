{
  lib,
  userConfig,
  ...
}:
{
  # Enable Steam if gaming is needed
  programs.steam = lib.mkIf (userConfig.machine ? gaming && userConfig.machine.gaming) {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
