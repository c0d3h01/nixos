{
  pkgs,
  lib,
  userConfig,
  ...
}:
let
  inherit (lib) mkForce;
  isServer = userConfig.machineConfig.server.enable;
in
{
  networking.firewall = {
    enable = true;
    package = pkgs.iptables;

    # allow servers to be pinnged, but not our clients
    allowPing = isServer;

    allowedTCPPorts = [
      443
      8080
    ];
    allowedUDPPorts = [ ];

    allowedTCPPortRanges = [ ];
    allowedUDPPortRanges = [ ];

    # make a much smaller and easier to read log
    logReversePathDrops = true;
    logRefusedConnections = false;

    # Don't filter DHCP packets, according to nixops-libvirtd
    checkReversePath = mkForce false;
  };
}
