{
  checks = {
    treefmt = perSystem: { pkgs, ... }: {
      command = "treefmt --fail-on-change";
      package = config.formatter;
    };
  };
}
