{ config
, lib
, user
, ...
}:
{
  imports = [
    ./audio.nix
    ./auth.nix
    ./boot.nix
    ./desktop
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./services.nix
  ];

  system.stateVersion = user.stateVersion;
  networking.hostName = user.hostname;

  # NixOS configuration
  nixpkgs = {
    config = lib.mkForce {
      allowUnfree = true;
      tarball-ttl = 0;
      android_sdk.accept_license = true;
    };
  };
}
