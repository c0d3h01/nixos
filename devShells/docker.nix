{
  pkgs ? import <nixpkgs> { system = "x86_64-linux"; },
}:

pkgs.dockerTools.buildLayeredImage {
  name = "nix-hello";
  tag = "latest";
  contents = [
    pkgs.hello
  ];
}
