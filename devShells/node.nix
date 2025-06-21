{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Node Dev Shell";
  buildInputs = with pkgs; [
    nodejs
    yarn
    eslint
    prettierd
  ];
  shellHook = ''
    echo "🟩 Node.js development shell. Use 'npm' or 'yarn' as needed."
    exec zsh
  '';
}
