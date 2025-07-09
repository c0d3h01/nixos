{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "R Dev Shell";
  buildInputs = with pkgs; [
    R
    # rPackages.tidyverse
    rPackages.devtools
    # rPackages.shiny
    # rPackages.knitr
    # rPackages.rmarkdown
  ];
  # shellHook = ''
  # '';
}
