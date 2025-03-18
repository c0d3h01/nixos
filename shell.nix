{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "dev-environment";
  buildInputs = [
    # GTK & Graphics
    pkgs.gtk3
    pkgs.glfw
    pkgs.glew
    pkgs.glm
  ];

  shellHook = ''
    export PKG_CONFIG_PATH="${pkgs.gtk3}/lib/pkgconfig:$PKG_CONFIG_PATH"
    echo "Start developing env..."
  '';
}
