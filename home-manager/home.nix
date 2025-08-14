{
  userConfig,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
    shell.enableZshIntegration = true;
    shell.enableBashIntegration = true;
  };
}
