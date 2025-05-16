{ config, pkgs, lib, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      # Basic Settings
      TLP_ENABLE = 1;
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;

      # CPU Frequency Scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # AMD CPU Specific
      AMD_PSTATE_CPU_BOOST_ON_AC = 1;
      AMD_PSTATE_CPU_BOOST_ON_BAT = 0;
      AMD_PSTATE_EPP_POLICY_ON_AC = "performance";
      AMD_PSTATE_EPP_POLICY_ON_BAT = "power";

      # Disk and I/O Settings
      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;

      # Runtime Power Management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_BLACKLIST = "amdgpu";

      # USB AutoSuspend
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST = "btusb";
      USB_EXCLUDE_PHONE = 1;
      USB_EXCLUDE_AUDIO = 1;

      # PCIe ASPM (Power Saving)
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";

      # Radio Devices
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wwan";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";

      # WiFi Power Saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      # Battery Charge Thresholds (if supported)
      # Only works on supported ThinkPads or Dell with battery controller access
      # START_CHARGE_THRESH_BAT0 = 75;
      # STOP_CHARGE_THRESH_BAT0 = 90;

      # Misc
      NATACPI_ENABLE = 1;
      TPACPI_ENABLE = 0;
      TPSMAPI_ENABLE = 0;

      # Logging & Debug
      TLP_DEBUG = "rf runtime pm usb disk battery";
    };
  };

  # Kernel module needed for CPU performance tweaks
  boot.kernelModules = [ "msr" ];

  environment.systemPackages = with pkgs; [
    tlp
  ];

  # Conflicting services are off
  services.power-profiles-daemon.enable = false;
}
