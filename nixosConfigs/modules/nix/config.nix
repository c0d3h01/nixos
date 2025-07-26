{
  # Nixpkgs configuration settings
  nixpkgs = {
    config = {
      # Allow proprietary/unfree packages to be installed
      allowUnfree = true;

      # Allow installation of packages with insecure status
      allowInsecure = true;

      # Auto-accept Android SDK license agreements
      android_sdk.accept_license = true;

      # Permit all insecure packages (should be more specific in production)
      permittedInsecurePackages = [ ];

      # A funny little hack to make sure that *everything* is permitted
      allowUnfreePredicate = _: true;

      # I allow packages that are not supported by my system
      # since I sometimes need to try and build those packages that are not directly supported
      allowUnsupportedSystem = true;
    };
  };
}
