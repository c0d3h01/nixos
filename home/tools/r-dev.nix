{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.myRDev.enable = lib.mkEnableOption "Enable R Development Environment";

  config = lib.mkIf config.myRDev.enable {
    home.packages = with pkgs; [
      R
      rstudio
      rPackages.tidyverse
      rPackages.devtools
      rPackages.shiny
      rPackages.knitr
      rPackages.rmarkdown
    ];
  };
}
