{ agenix
, user
, system
, ...
}: {
  imports = [ agenix.nixosModules.default ];
  environment.systemPackages = [ agenix.packages.${system}.default ];

  age = {
    identityPaths = [ "/home/${user.username}/dotfiles/secrets/keys/default.key" ];
    secrets = { };
  };
}
