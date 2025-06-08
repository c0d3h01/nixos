{ pkgs, ... }:
pkgs.mkShell {
  name = "rust-devshell";
  buildInputs = [
    pkgs.rustup
    pkgs.cargo
    pkgs.rustc
    pkgs.rustfmt
    pkgs.clippy
  ];
  shellHook = ''
    echo "🦀 Rust development shell. Run 'rustup default stable' for default toolchain."
  '';
}
