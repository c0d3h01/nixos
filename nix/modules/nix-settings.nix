{ config
, lib
, ...
}:
{
  nixpkgs = {
    config = lib.mkForce {
      allowUnfree = true;
      tarball-ttl = 0;
      android_sdk.accept_license = true;
    };
  };
  nix = {
    settings = lib.mkMerge [
      ({
        keep-outputs = true;
        keep-derivations = true;
        keep-going = true;
        builders-use-substitutes = true;
        accept-flake-config = true;
        http-connections = 0;
        auto-optimise-store = true;
        max-jobs = "auto";
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
        ];
      })
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };
}
