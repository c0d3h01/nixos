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
  # shellHook = ''
  # '';
}
