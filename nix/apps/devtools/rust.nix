{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustup
    cargo-edit
    cargo-watch
    cargo-audit
    cargo-expand
    cargo-outdated
  ];

  programs.zsh.shellInit = ''
    export RUSTUP_HOME="$HOME/.rustup"
    export CARGO_HOME="$HOME/.cargo"
    # source ${pkgs.rustup}/share/zsh/site-functions/_rustup
  '';
}
