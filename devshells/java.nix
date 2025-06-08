{ pkgs, ... }:
pkgs.mkShell {
  name = "java-devshell";
  buildInputs = [
    pkgs.openjdk21
    pkgs.maven
    pkgs.gradle
  ];
  shellHook = ''
    echo "☕ Java development shell. Use 'mvn' or 'gradle' as needed."
  '';
}
