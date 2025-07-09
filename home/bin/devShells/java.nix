{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Java Dev Shell";
  buildInputs = with pkgs; [
    jdk24
    maven
    gradle
  ];
  # shellHook = ''
  # '';
}
