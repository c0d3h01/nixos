{
  disko.devices = {
    nodev."/@" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=8G"
        "mode=755"
      ];
    };

    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];              
                subvolumes = {

                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:1"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                    ];
                  };

                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:1"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                    ];
                  };

                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:7"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                    ];
                  };

                  "/@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "subvol=@persist"
                      "compress=zstd"
                      "noatime"
                      "ssd"
                    ];
                  };

                  "/@cache" = {
                    mountpoint = "/var/cache";
                    mountOptions = [
                      "noatime"
                      "nodatacow"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                    ];
                  };

                  "/@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [
                      "noatime"
                      "nodatacow"
                      "ssd"
                    ];
                  };

                  "/@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:1"
                      "ssd"
                      "space_cache=v2"
                      "commit=120"
                    ];
                  };

                  "/@swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "6G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}