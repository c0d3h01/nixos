{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = "B4242C21BAF74B7C";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Harshal Sawant";
        email = "harshalsawant.dev@gmail.com";
      };

      init.defaultBranch = "master";
      credential.helper = "store";
      protocol.version = 2;

      core = {
        editor = "nvim";
        autocrlf = false;
        safecrlf = true;
        preloadindex = true;
        untrackedCache = true;
      };

      commit = {
        verbose = true;
        template = "${config.home.homeDirectory}/.config/git/message";
      };

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      pull.rebase = true;
      rebase.autosquash = true;

      # GPG — now primary
      gpg.format = "openpgp";
      tag.gpgSign = true;
      commit.gpgSign = true;

      # Minimal URL shortcuts (most used)
      url."https://github.com/".insteadOf = "gh:";
      url."https://gitlab.com/".insteadOf = "gl:";

      advice = {
        statusHints = false;
        detachedHead = false;
      };

      # Optional but high-ROI performance
      feature.manyFiles = true;
      maintenance.auto = 1;
      maintenance.strategy = "incremental";
    };
  };
}
