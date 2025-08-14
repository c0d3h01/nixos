{ config, ... }:
{
  config = {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      exitShellOnExit = true;
    };
  };
}
