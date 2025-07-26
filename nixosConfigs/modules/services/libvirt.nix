{
  pkgs,
  userConfig,
  ...
}:

{
  users.users.${userConfig.username}.extraGroups = [
    "libvirtd"
    "kvm"
  ];
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };
}
