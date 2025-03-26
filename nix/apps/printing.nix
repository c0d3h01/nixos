{ config
, pkgs
, ...
}:
{
  services = {
    printing.enable = true;
    printing.drivers = with pkgs; [ gutenprint hplip ];
    avahi.enable = true;
    avahi.openFirewall = true;
  };
}
