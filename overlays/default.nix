{ inputs }:
{

  default = final: prev: {
    # Stable Nixpkgs config, i use unstable as default
    stable = import inputs.nixpkgs-stable {
      system = prev.stdenv.system;
      config.allowUnfree = true;
    };
  };
}
