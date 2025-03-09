{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # Python modules
    python312Full
    python312Packages.pip
    python312Packages.django
    python312Packages.flask
    python312Packages.fastapi
    python312Packages.jinja2
    python312Packages.jupyterlab

    # Type checker but also provides the main LSP functionality.
    pyright

    # Formatter and linter with LSP integration.
    ruff
  ];
}

