{
  config,
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      # git modules
      git
      git-extras
      git-crypt
      git-revise
      ghq
      hub
      gh
      git-lfs
      delta
      lazygit
      mergiraf
      pre-commit
    ];
  };
}
