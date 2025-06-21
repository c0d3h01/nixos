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
  shellHook = ''
    echo "☕ Java development shell. Use 'mvn' or 'gradle' as needed."
    exec zsh
  '';
}
