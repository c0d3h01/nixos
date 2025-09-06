{
  userConfig,
  lib,
  ...
}:

{
  imports = [
    ./modules
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  manual.manpages.enable = false;
  programs.man.enable = lib.mkDefault false;

  home = {
    inherit (userConfig) username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = lib.trivial.release;
  };
}
