#!/bin/sh

# Define dotfiles location
SCRIPT_DIR=~/dotfiles

# Check if dotfiles repo exists, clone if not
if [ ! -d "$SCRIPT_DIR/.git" ]; then
  echo "-*-> Cloning dotfiles..."
  git clone https://github.com/c0d3h01/dotfiles $SCRIPT_DIR 
fi

# Change to dotfiles directory
cd $SCRIPT_DIR || exit 1

# Cleanup Xdg user directories
echo "-*-> Cleaning up XDG directories..."
rm ~/.config/user-dirs.dirs* && echo "Removed user-dirs.dirs"
xdg-user-dirs-update && echo "Updated XDG directories"

# Rebuild system using flake
echo "-*-> Applying system configuration..."
sudo nixos-rebuild switch --flake .#NixOS --show-trace --option experimental-features "nix-command flakes"

echo "*** Setup complete! Your system is now configured. ***"
