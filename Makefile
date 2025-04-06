# === CONFIG ===

TARGET ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
HM_PROFILE ?= $(USER)@$(TARGET)

# === Dotfiles Installations ===

install: 
	@echo "[*] Installing dotfiles..."
	@echo "    [*] Installing git..."
	nix run nixpkgs#git clone https://github.com/c0d3h01/dotfiles.git ~/dotfiles && cd ~/dotfiles

	@echo "    [*] Removing old and copying new hardware config..."
	rm hosts/c0d3h01/hardware-configuration.nix && cp /etc/nixos/hardware-configuration.nix hosts/c0d3h01/

	@echo "    [*] Installing NixOS system config..."
	nixos-rebuild switch --flake $(FLAKE)#$(TARGET) --option experimental-features 'nix-command flakes' --fast

	@echo "    [*] Done!"

# === SYSTEM COMMANDS ===

upd:
	@echo "[+] Rebuilding system for flake target: $(TARGET)"
	sudo nixos-rebuild switch --flake $(FLAKE)#$(TARGET)

upgrade: 
	@echo "[*] Upgrading system for flake target: $(TARGET)"
	sudo nixos-rebuild switch --upgrade --flake $(FLAKE)#$(TARGET) --upgrade

test:
	@echo "[*] Test build (no switch): $(TARGET)"
	sudo nixos-rebuild test --flake $(FLAKE)#$(TARGET)

build:
	@echo "[*] Building system config only: $(TARGET)"
	sudo nixos-rebuild build --flake $(FLAKE)#$(TARGET)

dry:
	@echo "[*] Preview changes for: $(TARGET)"
	sudo nixos-rebuild dry-activate --flake $(FLAKE)#$(TARGET)

# === SYSTEM MAINTENANCE ===

clean:
	@echo "[*] Removing old generations and freeing space..."
	sudo nix-collect-garbage -d
	nix store gc

bootctl:
	@echo "[*] Updating bootloader entries (systemd-boot)..."
	sudo bootctl update

update:
	@echo "[*] Updating flake inputs..."
	nix flake update

# === HELP ===

help:
	@echo "-*-[  NixOS Workflow Commands ] -*-"
	@echo ""
	@echo "Dotfiles installation:"
	@echo "  make install       – Install dotfiles"
	@echo ""
	@echo "System:"
	@echo "  make upd           – Rebuild & switch system config"
	@echo "  make test          – Test rebuild without switching"
	@echo "  make build         – Just build system config"
	@echo "  make dry           – Preview config changes"
	@echo "  make update        – Update flake inputs"
	@echo "  make clean         – Clean old generations and GC"
	@echo "  make bootctl       – Update bootloader (systemd-boot)"
	@echo ""
	@echo " [*] Default TARGET: $(TARGET), USER: $(USER)"
