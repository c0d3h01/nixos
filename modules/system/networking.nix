{
  services.resolved.enable = true;
  systemd.network.wait-online.enable = false;

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      connectionConfig."connection.mdns" = 2;
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };
}
