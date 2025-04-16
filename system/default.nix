{ userConfig, ... }:

{
  imports = [
    ./applications
    ./development
    ./laptop
    ./modules
    ../overlays
  ];

  system.stateVersion = userConfig.stateVersion;
  networking.hostName = userConfig.hostname;
}
