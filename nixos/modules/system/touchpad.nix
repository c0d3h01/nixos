{
  lib,
  config,
  userConfig,
  ...
}:

{
  config = lib.mkIf (userConfig.machineConfig.type == "laptop") {
    # Input settings for libinput
    services.libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
        accelSpeed = "0";
        middleEmulation = false;
      };

      # touchpad settings
      touchpad = {
        naturalScrolling = true;
        tapping = true;
        clickMethod = "clickfinger";
        disableWhileTyping = true;
      };
    };
  };
}
