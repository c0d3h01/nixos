{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "Python Dev Shell";
  buildInputs = [
    (pkgs.python313.withPackages (
      ps: with ps; [
        pip
        uv
        pygame
        flask
        virtualenv
        # flake8
        sympy
        numpy
        scipy
        pandas
        scikit-learn
        matplotlib
        # torch
      ]
    ))
    pkgs.pyright
    pkgs.ruff
  ];
  shellHook = ''
    echo "Use 'poetry' 'pip' 'uv'"
    echo "Python: $(python --version)"
    echo "python -m venv .venv && source ./.venv/bin/activate"
  '';
}
