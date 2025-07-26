{
  lib,
  userConfig,
  ...
}:
let
  # SSH keys and password for c0d3h01
  c0d3h01Keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSjL8HGjiSAnLHupMZin095bql7A8+UDfc7t9XCZs8l harshalsawant.dev@gmail.com"
  ];
  hashedPass = "$6$aXq5Okrj6w0/MKTc$Bx9M4vijoRTa7wd8W0.xOr.kItJo4o9RYcvWto/o7VybA9DIG2GcFYPw0W6Y1wZZ0C/RIuaJOkrCCa.4slxGG.";

  # Check if current user is c0d3h01
  isC0d3h01 = userConfig.username == "c0d3h01";
in
{
  imports = [
    ./disko-btrfs.nix
    ./hardware.nix
  ];

  users.users = lib.mkIf isC0d3h01 {
    root = {
      # Allow the user to log in as root without a password.
      hashedPassword = "";
      openssh.authorizedKeys.keys = c0d3h01Keys;
    };

    c0d3h01 = {
      home = "/home/c0d3h01";
      hashedPassword = hashedPass;
      openssh.authorizedKeys.keys = c0d3h01Keys;
      extraGroups = [
        "adbusers"
        "wireshark"
        "usbmon"
      ];
    };
  };
}
