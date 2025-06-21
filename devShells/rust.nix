{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Rust Dev Shell";
  buildInputs = with pkgs; [
    rustup
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer
  ];
  shellHook = ''
    echo "🦀 Rust development shell."
    exec zsh
  '';
}
