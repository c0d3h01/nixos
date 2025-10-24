{
  imports = [
    ./aliases.nix
    ./bash.nix
    ./zsh.nix
    ./fish.nix
  ];

  home.shell.enableIonIntegration = true;
}