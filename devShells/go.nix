{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Go Dev Shell";
  buildInputs = with pkgs; [
    go
    gopls
    gotools
    golangci-lint
  ];
  shellHook = ''
    echo "🐹 Go development shell. Use 'go mod' for dependency management."
    exec zsh
  '';
}
