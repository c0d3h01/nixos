{
  # ssh -L 9999:localhost:8384 nixos
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/srv/storage/syncthing";
  };
}
