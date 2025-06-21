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
        # jupyter
        sympy
        # numpy
        # scipy
        # pandas
        # scikit-learn
        # matplotlib
        # torch
      ]
    ))
    pkgs.pyright
    pkgs.ruff
  ];
  shellHook = ''
    echo "* Python development shell. Use 'poetry' or 'pip' as needed."
    echo "Python: $(python --version)"
    echo "python -m venv .venv && source ./.venv/bin/activate"
    exec zsh
  '';
}
