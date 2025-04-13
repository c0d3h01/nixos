{ userConfig, ... }:

{
  imports = [
    ./applications
    ./development
    ./hosts/laptop
    ./modules
  ];

  system.stateVersion = userConfig.stateVersion;
  networking.hostName = userConfig.hostname;
}
