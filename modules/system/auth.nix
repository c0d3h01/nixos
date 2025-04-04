{
  # GPG Agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # SSH Daemon
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      MaxAuthTries = 3;
    };
  };
}
