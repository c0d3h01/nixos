{
  services.resolved.enable = true;
  systemd.network.wait-online.enable = false;

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}
