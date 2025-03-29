{ config
, pkgs
, lib
, ...
}:
{
  imports = [ ./devtools ];

  # Flatpak apps support
  services = {
    flatpak.enable = false;
  };

  # VirtualMachine
  # virtualisation.libvirtd.enable = true;
  # users.users.${username}.extraGroups = [ "libvirtd" ];

  # Allow running dynamically linked binaries
  programs.nix-ld.enable = true;

  # Environment packages
  environment.systemPackages =
    let
      devTools = with pkgs; [
        # Utilities

        # Editors and IDEs
        vscodium-fhs
        vscode-fhs
        jetbrains.webstorm

        # Version control
        github-desktop

        # JavaScript/TypeScript
        nodejs
        nodePackages.node2nix

        # C/C++
        gcc
        gdb
        clang
        gnumake
        cmake
        ninja

        # Graphics libraries
        glib
        glfw
        glew
        glm
        sfml

        # GTK development tools
        gtk3
        gtk4
        gobject-introspection
        pkg-config
        gtkmm4 # C++ bindings for GTK4
        gtkmm3 # C++ bindings for GTK3

        # API Development
        postman
      ];

      communicationApps = with pkgs; [
        discord
        telegram-desktop
        slack
        zoom-us
        element-desktop
      ];

      desktopApps = with pkgs; [
        # Custom patched Notion
        (pkgs.callPackage ./notion-app-enhanced { })
        libreoffice
        tor-browser
        spotify
        transmission_4-gtk
        anydesk
      ];

      networkingTools = with pkgs; [
        metasploit
        nmap
        wireshark
        tcpdump
      ];

      androidTools = with pkgs; [
        android-studio
        flutter
        openjdk
        gradle
      ];
    in
    devTools ++ communicationApps ++ desktopApps ++ networkingTools ++ androidTools;
}
