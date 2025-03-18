{ lib, ... }:

{
  # Enables wireless support via wpa_supplicant (uncomment if needed)
  # networking.wireless.enable = true;
  # Configure network proxy if necessary (uncomment and modify if needed)
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # -*-[ Network manager configurations ]-*-
  networking.networkmanager.enable = true;
  networking.networkmanager.settings.connection."wifi.powersave" = lib.mkForce 2;
  systemd.network.wait-online.enable = false;

  # -*-[ DNS ]-*-
  # Enable systemd-resolved for DNS resolution
  services.resolved.enable = true;

  # Disable NetworkManager's internal DNS handling
  networking.networkmanager.dns = lib.mkForce "none";

  # Set custom DNS servers (IPv4 and IPv6)
  networking.nameservers = [
    "1.1.1.1"  # Cloudflare DNS
    "1.0.0.1"  # Cloudflare DNS
    "2606:4700:4700::1111"  # Cloudflare IPv6 DNS
    "2606:4700:4700::1001"  # Cloudflare IPv6 DNS
  ];

  # Prevent dhcpcd from overwriting /etc/resolv.conf
  networking.dhcpcd.extraConfig = "nohook resolv.conf";

  # Configure NetworkManager to use systemd-resolved and prioritize DNS
  networking.networkmanager.connectionConfig = {
    "connection.mdns" = 2;  # Enable mDNS
    "ipv4.dns-priority" = -1;  # Ensure systemd-resolved is used
    "ipv6.dns-priority" = -1;  # Ensure systemd-resolved is used
  };
  
  # -*-[ Firewall ]-*-
  # Enable the firewall
  networking.firewall.enable = true;

  # Open TCP and UDP ports for GSConnect
  networking.firewall.allowedTCPPorts = [ 1716 ]; # GSConnect
  networking.firewall.allowedUDPPorts = [ 1716 ]; # GSConnect
}
