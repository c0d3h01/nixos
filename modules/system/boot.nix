{ pkgs
, ...
}: {

  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    initrd = {
      verbose = false;
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = [ ];
    };

    kernelParams = [
      "preempt=full"
      "mitigations=off"
      "nowatchdog"
      "nmi_watchdog=0"
      "loglevel=3"
      "quiet"
      "splash"
      "page_alloc.shuffle=1"
      "randomize_kstack_offset=on"
      "slab_nomerge"
      "pti=on"
      "iommu=pt"
      "amd_iommu=on"
      "pcie_aspm=performance"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    kernel.sysctl = {
      "net.core.rmem_max" = 33554432;
      "net.core.wmem_max" = 33554432;
      "net.core.rmem_default" = 16777216;
      "net.core.wmem_default" = 16777216;
      "net.core.optmem_max" = 40960;
      "net.ipv4.tcp_mem" = "786432 1048576 26777216";
      "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
      "net.ipv4.tcp_wmem" = "4096 65536 16777216";
      "net.core.netdev_max_backlog" = 100000;
      "net.core.netdev_budget" = 100000;
      "net.core.netdev_budget_usecs" = 100000;
      "net.ipv4.tcp_max_syn_backlog" = 30000;
      "net.ipv4.tcp_max_tw_buckets" = 2000000;
      "net.ipv4.tcp_tw_reuse" = 1;
      "net.ipv4.tcp_fin_timeout" = 10;
      "net.ipv4.udp_rmem_min" = 8192;
      "net.ipv4.udp_wmem_min" = 8192;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_no_metrics_save" = 1;
      "net.ipv4.tcp_moderate_rcvbuf" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.ipv4.tcp_keepalive_intvl" = 10;
      "net.ipv4.tcp_keepalive_probes" = 6;
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_expire_centisecs" = 3000;
      "vm.dirty_writeback_centisecs" = 500;
      "kernel.kptr_restrict" = 2;
      "kernel.yama.ptrace_scope" = 2;
      "kernel.perf_event_paranoid" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "fs.file-max" = 2097152;
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 1024;
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };
      timeout = 3;
    };
  };
}
