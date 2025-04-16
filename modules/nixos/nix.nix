{
  config,
  inputs,
  outputs,
  userConfig,
  lib,
  ...
}:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      tarball-ttl = 0;
      android_sdk.accept_license = true;
    };
  };

  system.stateVersion = userConfig.stateVersion;
  networking.hostName = userConfig.hostname;

  # build takes forever
  documentation.nixos.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix = {
    settings = {
      warn-dirty = false;
      show-trace = true;
      keep-going = true;
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0; # Use all available cores

      trusted-users = [
        "root"
        "@wheel"
      ];

      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
