{ ... }:

{
  # Enable system optimization services
  services = {
    # Enable fstrim for SSDs
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    # Disable power-profiles-daemon for conflict prevention
    power-profiles-daemon.enable = false;
    # Enable TLP for power management
    tlp = {
      enable = true;
      # TLP settings
      settings = {
        # CPU scaling governor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";

        # Energy performance policy
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        # CPU driver operation mode
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";

        # CPU performance limits
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

        # Turbo boost settings
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;

        # Sleep mode settings
        MEM_SLEEP_ON_AC = "deep";
        MEM_SLEEP_ON_BAT = "deep";

        # Platform power profile
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "performance";

        # AMD GPU power settings
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "performance";
        RADEON_POWER_PROFILE_ON_AC = "high";
        RADEON_POWER_PROFILE_ON_BAT = "high";

        # Disable scheduler power saving for better performance
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 0;
      };
    };
  };
}
