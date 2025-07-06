{
  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                ];

                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "defaults"
                      "noatime"
                      "compress=zstd"
                      "commit=120"
                    ];
                  };

                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "defaults"
                      "noatime"
                      "compress=zstd"
                      "commit=120"
                    ];
                  };

                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "defaults"
                      "noatime"
                      "compress=zstd"
                      "space_cache=v2"
                    ];
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
