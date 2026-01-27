{
  config,
  pkgs,
  lib,
  ...
}: {
  # Activation Script
  home.activation.setupDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    DOTFILES_DIR="${config.home.homeDirectory}/.dotfiles"
    REPO_URL="https://github.com/c0d3h01/dotfiles.git"

    if [ ! -d "$DOTFILES_DIR" ]; then
      ${pkgs.git}/bin/git clone --recurse-submodules "$REPO_URL" "$DOTFILES_DIR"
      ${pkgs.stow}/bin/stow -d "$DOTFILES_DIR" -t "${config.home.homeDirectory}" .
    fi
  '';
}
