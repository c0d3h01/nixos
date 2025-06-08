{ pkgs, ... }:
pkgs.mkShell {
  name = "python-devshell";
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.virtualenv
    pkgs.black
    pkgs.flake8
    pkgs.mypy
    pkgs.poetry
  ];
  shellHook = ''
    echo "🐍 Python development shell. Use 'poetry' or 'pip' as needed."
  '';
}
