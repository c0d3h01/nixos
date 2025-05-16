{
  pkgs,
  userConfig,
  ...
}:

{
  imports = [
    ./modules
    ./apps
  ];

  programs.home-manager.enable = true;
  services.syncthing.enable = true;

  home = {
    username = userConfig.username;
    homeDirectory = "/home/${userConfig.username}";
    stateVersion = userConfig.stateVersion;

    packages = with pkgs; [
      # Terminal
      kitty
      neovim

      # Utilities
      tmux
      coreutils
      fastfetch
      xclip
      curl
      wget
      tree
      asar
      fuse
      nh
      stow
      zellij
      bat
      direnv
      zoxide
      eza
      ripgrep
      fzf
      fd
      file
      bashInteractive
      lsd
      tea
      less
      findutils
      hub

      # Nix Tools
      nix-prefetch-github

      # Language Servers
      lua-language-server
      nil

      # System Monitoring
      inxi
      procs
      glances
      htop

      # Extractors
      unzip
      unrar
      p7zip
      xz
      zstd
      cabextract

      # git
      git
      git-lfs
      gh
      delta
      mergiraf
      lazygit
    ];
  };
}
