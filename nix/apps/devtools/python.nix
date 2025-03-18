{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # Python environment modules
    (pkgs.python312.withPackages (ps: with ps; [
      pip
      django
      flask
      sympy
      jupyterlab
    ]))

    # Type checker but also provides the main LSP functionality.
    pyright

    # Formatter and linter with LSP integration.
    ruff
  ];
}

