{ config
, username
, pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [ gnome-boxes ];
  virtualisation.libvirtd.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];
}
