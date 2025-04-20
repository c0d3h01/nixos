{ pkgs, ... }:
{

  imports = [ ./development ];

  # Flatpak apps support
  services.flatpak.enable = true;

  # VirtualMachine
  # virtualisation.libvirtd.enable = true;
  # users.users.${userConfig.username}.extraGroups = [ "libvirtd" ];

  # Allow running dynamically linked binaries
  programs.nix-ld.enable = true;

  # Firefox install
  programs.firefox.enable = true;

  # Environment packages
  environment.systemPackages =
    let
      stablePkgs = with pkgs.stable; [
      ];

      unstablePkgs = with pkgs; [
        # Notion Enhancer With patches
        (pkgs.callPackage ./notion-app-enhanced { })

        # Editors and IDEs
        vscode-fhs
        android-studio

        # Developement desktop apps
        postman
        github-desktop

        # Communication apps
        vesktop
        telegram-desktop
        slack
        element-desktop
        zoom-us

        # Common desktop apps
        spotify
        anydesk

        # Network tools
        metasploit
        nmap
        tcpdump
        aircrack-ng
        wireshark

        # -+ Common Developement tools
        nodejs

        # C/C++
        gdb
        clang
        gnumake
        cmake
        ninja

        # Gtk tools
        gtk3
        gtk4
        pkg-config

        # Android Tools
        flutter
        openjdk
        android-tools
      ];
    in
    stablePkgs ++ unstablePkgs;
}
