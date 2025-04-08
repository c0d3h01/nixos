<div style="display: flex; align-items: center;">
    <img src="assets/README/chillet.png" height="100"/>
    <img src="assets/README/glow-text.svg" alt="Crafted Dotfiles by c0d3h01" style="margin-left: 12px;"/>
</div>

## 📂 **Installation**
```bash
sudo nixos-rebuild switch --flake github:c0d3h01/dotfiles#NixOS --fast
```

## 📂 **Home Manager config Installation**
```bash
home-manager switch --flake .
```

### **Refresh Git Cloning While Building**
> If you need to **force a fresh clone of the repository** while rebuilding, use `--refresh`:
```bash
sudo nixos-rebuild switch --flake github:c0d3h01/dotfiles#NixOS --refresh
```