{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    myModules.rustTools = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Rust modules";
    };
  };

  config = lib.mkIf config.myModules.rustTools {
    environment.systemPackages = with pkgs; [
      rustup
      rustfmt
      rust-analyzer
    ];
  };
}
