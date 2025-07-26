{
  lib,
  ...
}:
let
  inherit (lib) genAttrs;
in
{
  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # run appimages with appimage-run
  boot.binfmt.registrations =
    genAttrs
      [
        "appimage"
        "AppImage"
      ]
      (ext: {
        recognitionType = "extension";
        magicOrExtension = ext;
        interpreter = "/run/current-system/sw/bin/appimage-run";
      });
}
