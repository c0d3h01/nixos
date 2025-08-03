{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.sleek;
      colorScheme = "Nord";

      enabledCustomApps = with spicePkgs.apps; [
        ncsVisualizer
        newReleases
      ];

      enabledExtensions = with spicePkgs.extensions; [
        beautifulLyrics
        goToSong
        history
        adblock
      ];
    };
}
