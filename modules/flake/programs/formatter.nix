{ lib, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      formatter = pkgs.treefmt.withConfig {
        runtimeInputs = with pkgs; [
          actionlint
          deadnix
          keep-sorted
          nixfmt-rfc-style
          shellcheck
          shfmt
          statix
          stylua
          taplo
          # rustfmt
          # ruff
          # mypy
          # yamlfmt
          # clang

          (writeShellScriptBin "statix-fix" ''
            for file in "$@"; do
              ${lib.getExe statix} fix "$file"
            done
          '')
        ];

        settings = {
          on-unmatched = "info";
          tree-root-file = "flake.nix";

          excludes = [
            ".git-crypt/*"
            "secrets/*"
            "configs/*"
          ];

          formatter = {
            actionlint = {
              command = "actionlint";
              includes = [
                ".github/workflows/*.yml"
                ".github/workflows/*.yaml"
              ];
            };

            deadnix = {
              command = "deadnix";
              includes = [ "*.nix" ];
            };

            keep-sorted = {
              command = "keep-sorted";
              includes = [ "*" ];
            };

            nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
              excludes = [ ];
            };

            shellcheck = {
              command = "shellcheck";
              includes = [
                "*.sh"
                "*.bash"
                # direnv
                "*.envrc"
                "*.envrc.*"
                "*.bashrc"
                "*.zshrc"
              ];
            };

            shfmt = {
              command = "shfmt";
              options = [
                "-s"
                "-w"
                "-i"
                "2"
              ];
              includes = [
                "*.sh"
                "*.bash"
                # direnv
                "*.envrc"
                "*.envrc.*"
                "*.bashrc"
                "*.zshrc"
              ];
              excludes = [ ];
            };

            statix = {
              command = "statix-fix";
              options = "";
              includes = [ "*.nix" ];
              excludes = [ ];
            };

            # ruff-format = {
            #   command = "";
            #   options = "";
            #   includes = [ ];
            #   excludes = [ ];
            # };

            # yamlfmt = {
            #   command = "";
            #   options = "";
            #   includes = [ ];
            #   excludes = [ ];
            # };

            stylua = {
              command = "stylua";
              options = "";
              includes = [ "*.lua" ];
              excludes = [ ];
            };

            taplo = {
              command = "taplo";
              options = "format";
              includes = [ "*.toml" ];
              excludes = [ ];
            };
          };
        };
      };
    };
}
