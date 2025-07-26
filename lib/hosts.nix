{
  # Laptop machine
  laptop = {
    username = "c0d3h01";
    hostname = "fedora";
    email = "harshalsawant.dev@gmail.com";
    fullName = "Harshal Sawant";
    system = "x86_64-linux";

    machine = {
      type = "laptop";
      hasGUI = true;
      gpuType = "amd";
      opengl = true;
      hasBattery = true;
      gaming = false;
    };

    git = {
      userName = "c0d3h01";
      userEmail = "harshalsawant.dev@gmail.com";
      signing = {
        key = "YOUR_GPG_KEY";
        signByDefault = false;
      };
    };

    desktop = {
      wallpaper = "/assets/wallpaper.png";
      theme = "dark";
      windowManager = "gnome";
      fontSize = 11;
    };

    dev = {
      wine = false;
      container = "podman";
      db = false;
      defaultEditor = "nvim";
      shell = "zsh";
      terminalFont = "JetBrains Mono";
      languages = [
        "rust"
        "python"
        "javascript"
        "nix"
      ];
    };
  };
}
