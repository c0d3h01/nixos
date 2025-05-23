{
  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            "boot" = {
              size = "1M";
              type = "EF02"; # for grub MBR
              priority = 1;
            };
            "ESP" = {
              name = "nixos-esp";
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            plainSwap = {
              name = "nixos-swap";
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            root = {
              name = "root";
              end = "-0";
              content = {
                type = "filesystem";
                format = "f2fs";
                mountpoint = "/";
                extraArgs = [
                  "-O"
                  "extra_attr,inode_checksum,sb_checksum,compression"
                ];
                # Recommendations for flash: https://wiki.archlinux.org/title/F2FS#Recommended_mount_options
                mountOptions = [
                  "compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime,nodiscard"
                ];
              };
            };
            # root = {
            #   name = "nixos-root";
            #   size = "100%";
            #   content = {
            #     type = "btrfs";
            #     extraArgs = [ "-f" ];
            #     subvolumes = {
            #       "/@" = {
            #         mountpoint = "/";
            #         mountOptions = [
            #           "compress=zstd:1"
            #           "discard=async"
            #           "noatime"
            #           "ssd"
            #         ];
            #       };
            #       "/@home" = {
            #         mountpoint = "/home";
            #         mountOptions = [
            #           "compress=zstd:1"
            #           "discard=async"
            #           "noatime"
            #           "ssd"
            #         ];
            #       };
            #       "/@nix" = {
            #         mountpoint = "/nix";
            #         mountOptions = [
            #           "compress=zstd:1"
            #           "discard=async"
            #           "noatime"
            #           "ssd"
            #         ];
            #       };
            #       "/@log" = {
            #         mountpoint = "/var/log";
            #         mountOptions = [
            #           "compress=zstd:1"
            #           "discard=async"
            #           "noatime"
            #           "ssd"
            #         ];
            #       };
            #     };
            #   };
            # };
          };
        };
      };
    };
  };
}
