{ pkgs, ... }:
pkgs.mkShell {
  name = "go-devshell";
  buildInputs = [
    pkgs.go
    pkgs.gopls
    pkgs.gotools
    pkgs.golangci-lint
  ];
  shellHook = ''
    echo "🐹 Go development shell. Use 'go mod' for dependency management."
  '';
}
