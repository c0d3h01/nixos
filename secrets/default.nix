{
  inputs,
  config,
  ...
}:

{
  sops = {
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
    };

    secrets = {
      "passwd" = {
        sopsFile = ./c0d3h01/passwd.enc;
        path = "/${config.home.homeDirectory}/.config/sops/age/passwd";
        format = "binary";
      };
      "element-key" = {
        sopsFile = ./c0d3h01/element-key.enc;
        path = "/${config.home.homeDirectory}/.config/sops/age/element-key";
        format = "binary";
      };
    };
  };
}
