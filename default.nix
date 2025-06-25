{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Dotfiles Shell";
  # packages = with pkgs; [ pkgs.nix ];
  buildInputs = with pkgs; [
    nix
  ];
  # shellHook = ''
  # '';
}
