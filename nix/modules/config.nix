{ username
, ...
}:

{
  programs = {
    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = false;
  };
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
      GatewayPorts = "yes";
      X11Forwarding = true;
      AllowUsers = [ "${username}" ];
    };
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 200;
    priority = 100;
  };
}
