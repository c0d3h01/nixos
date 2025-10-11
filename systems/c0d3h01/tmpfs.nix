{
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=1777" "size=4G" ];
  };
}