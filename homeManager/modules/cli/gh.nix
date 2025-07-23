{
  lib,
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;

    extensions = lib.attrValues {
      inherit (pkgs)
        gh-copilot # copilot in the CLI
        gh-eco # explore the ecosystem
        ;
    };

    settings = {
      prompt = "enabled";
    };
  };
}
