{ pkgs, ... }:
pkgs.mkShell {
  name = "node-devshell";
  buildInputs = [
    pkgs.nodejs_20
    pkgs.yarn
    pkgs.npm
    pkgs.eslint
    pkgs.prettier
  ];
  shellHook = ''
    echo "🟩 Node.js development shell. Use 'npm' or 'yarn' as needed."
  '';
}
