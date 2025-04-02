{ config, system, pkgs, lib, agenix, user, ... }:

{
  imports = [ agenix.nixosModules.default ];

  environment.systemPackages = with pkgs; [ agenix ];

  age = {
    identityPaths = [
      "/home/${user.username}/.ssh/id_ed25519"
      "/home/${user.username}/dotfiles/secrets/keys/default.key"
    ];

    secrets = {
      "wireguard_key" = {
        file = ./secrets/wireguard_key.age;
        owner = user.username;
      };
    };
  };
}
