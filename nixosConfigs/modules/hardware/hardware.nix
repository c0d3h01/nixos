{
  config,
  lib,
  pkgs,
  userConfig,
  modulesPath,
  ...
}:
let
  # Auto-detect CPU vendor
  isAMD = userConfig.machine ? cpuType && userConfig.machine.cpuType == "amd";
  isIntel = userConfig.machine ? cpuType && userConfig.machine.cpuType == "intel";

  # Auto-detect GPU type (fallback to userConfig)
  gpuType = userConfig.machine.gpuType or "intel";

  # Dynamic kernel modules based on hardware
  cpuKernelModules =
    lib.optionals isAMD [
      "kvm-amd"
      "amd-pstate"
    ]
    ++ lib.optionals isIntel [
      "kvm-intel"
      "intel_pstate"
    ];

  gpuKernelModules =
    lib.optionals (gpuType == "amd") [
      "amdgpu"
    ]
    ++ lib.optionals (gpuType == "nvidia") [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ]
    ++ lib.optionals (gpuType == "intel") [
      "i915"
    ];

  # Dynamic kernel parameters
  cpuKernelParams =
    lib.optionals isAMD [
      "amd_pstate=active"
    ]
    ++ lib.optionals isIntel [
      "intel_pstate=active"
    ];

  # Auto-detect if laptop (has battery)
  isLaptop = userConfig.machine ? hasBattery && userConfig.machine.hasBattery;

  laptopKernelParams = lib.optionals isLaptop [
    "acpi_backlight=native"
    "pcie_aspm=force" # Power saving for PCIe
  ];
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ZRAM configuration
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = if isLaptop then 150 else 100;
  };

  boot.loader = {
    timeout = lib.mkForce 5;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ]; # For UEFI
      useOSProber = true;
      memtest86.enable = true;
    };
    systemd-boot = {
      enable = false;
      configurationLimit = 15;
      memtest86.enable = true;
      consoleMode = "auto";
    };
  };

  boot = {
    # Clean tmp dir on boot
    tmp.cleanOnBoot = true;

    # Kernel configuration
    kernelPackages = pkgs.linuxPackages_latest;

    # Dynamic kernel modules
    kernelModules = [
      "acpi_cpufreq" # CPU frequency scaling
      "fuse" # Filesystem in Userspace
    ]
    ++ cpuKernelModules
    ++ gpuKernelModules;

    extraModulePackages = [ ];

    supportedFilesystems = [
      "ntfs"
      "cifs"
      "nfs"
    ];

    # Dynamic kernel parameters
    kernelParams = [
      "nowatchdog"
      "mitigations=off"
      "splash"
      "quiet"
      "loglevel=3"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "usbcore.autosuspend=-1"
      "pti=auto"
      "iommu=pt"
    ]
    ++ cpuKernelParams
    ++ laptopKernelParams;

    initrd = {
      verbose = false;
      compressor = "zstd";
      compressorArgs = [
        "-19"
        "-T0"
      ];

      # Dynamic initrd modules
      kernelModules = [
        "nvme"
        "btrfs"
        "ahci"
        "sd_mod"
        "dm_mod"
        "xhci_pci"
      ]
      ++ lib.optionals (gpuType == "amd") [ "amdgpu" ]
      ++ lib.optionals (gpuType == "intel") [ "i915" ];

      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "dm_mod"
        "sr_mod"
      ];
    };
  };

  # Network configuration
  networking.useDHCP = lib.mkDefault true;

  # Platform detection
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # CPU microcode updates - dynamic based on CPU type
  hardware.cpu.amd.updateMicrocode = lib.mkIf isAMD (
    lib.mkDefault config.hardware.enableRedistributableFirmware
  );
  hardware.cpu.intel.updateMicrocode = lib.mkIf isIntel (
    lib.mkDefault config.hardware.enableRedistributableFirmware
  );

  # Enable firmware updates
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Laptop-specific hardware
  services.thermald.enable = lib.mkIf isIntel true; # Intel thermal management
  services.power-profiles-daemon.enable = lib.mkIf isLaptop true; # Power management
}
