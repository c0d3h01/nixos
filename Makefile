# Convenient commands for managing NixOS and dotfiles

.PHONY: switch build test update clean

# Apply system and home configurations
switch:
	sudo nixos-rebuild switch --flake ~/dotfiles/. --upgrade

# Build but don't apply
build:
	nixos-rebuild build --flake ~/dotfiles/.

# Test configuration in a temporary environment
test:
	nixos-rebuild test --flake ~/dotfiles/. --show-trace

# Update flake inputs
update:
	sudo nix flake update

# Clean old generations (use with caution)
clean:
	sudo nix-store --gc
	sudo nix-collect-garbage -d