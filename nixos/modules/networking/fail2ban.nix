{
  services.fail2ban = {
    enable = true;
    banaction = "nftables-multiport";
    ignoreIP = [
      "127.0.0.0/8"
      "::1"
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
      "169.254.0.0/16"
      "fc00::/7"
      "fe80::/10"
    ];

    bantime-increment = {
      enable = true;
      overalljails = true;
      rndtime = "5m";
      multipliers = "2 4 8 16 32 64 128 256";
      maxtime = "168h";
    };

    jails = {
      DEFAULT = {
        settings = {
          findtime = "10m";
        };
      };

      sshd = {
        settings = {
          enable = true;
          port = "ssh";
          filter = "sshd";
          backend = "systemd";
          logpath = "%(sshd_log)s";
        };
      };
    };
  };
}
