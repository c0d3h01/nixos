{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 30;
      command_timeout = 500;

      palette = "cyber";

      palettes.cyber = {
        pink = "#FF2D95";
        cyan = "#00E8FC";
        purple = "#B026FF";
        green = "#39FF14";
        yellow = "#FFE700";
        orange = "#FF6A00";
        red = "#FF003C";
        dim = "#6B7280";
      };

      # Prompt layout
      format = lib.concatStrings [
        "[╭─](bold cyan) "
        "[⟨](bold purple)"
        "$os"
        "$username"
        "[⟩](bold purple) "
        "$directory"
        "$git_branch"
        "$git_status"
        "$line_break"
        "[│ ](bold cyan)"
        "$nix_shell"
        "$python"
        "$nodejs"
        "$rust"
        "$golang"
        "$container"
        "$docker_context"
        "$line_break"
        "[╰─](bold cyan) "
        # "$cmd_duration"
        "$character"
      ];

      character = {
        success_symbol = "[▸](bold green)";
        error_symbol = "[✗](bold red)";
        vimcmd_symbol = "[◂](bold purple)";
      };

      username = {
        format = "[$user]($style)[@](dim) ";
        style_user = "bold pink";
        style_root = "bold red";
        show_always = true;
      };

      directory = {
        format = "[▸](bold purple)[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only = " ⊗";
        read_only_style = "bold red";
        truncation_length = 4;
        truncate_to_repo = true;

        substitutions = {
          "~/Documents" = "⟨DOC⟩";
          "~/Downloads" = "⟨DWN⟩";
          "~/Pictures" = "⟨IMG⟩";
          "~/Videos" = "⟨VID⟩";
          "~/Music" = "⟨MUS⟩";
          "~/Dev" = "⟨DEV⟩";
          "~/clg" = "⟨CLG⟩";
          "~/.config" = "⟨CFG⟩";
        };
      };

      os = {
        format = "[$symbol](bold cyan)";
        disabled = false;
        symbols = {
          Arch = "⟨Λ⟩ ";
          Debian = "⟨DEB⟩ ";
          Fedora = "⟨FED⟩ ";
          Linux = "⬢ ";
          Macos = "⟨MAC⟩ ";
          NixOS = "❄ ";
          Ubuntu = "⟨UBU⟩ ";
          Windows = "⟨WIN⟩ ";
        };
      };

      git_branch = {
        format = "[⟨⑂](bold purple) [$branch]($style) [⟩](bold purple) ";
        style = "bold green";
        truncation_length = 20;
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold yellow";
        conflicted = "[≋$count](bold red)";
        up_to_date = "[✓](bold green)";
        untracked = "[?$count](bold purple)";
        stashed = "[≡$count](bold cyan)";
        modified = "[△$count](bold yellow)";
        staged = "[●$count](bold green)";
        renamed = "[⟳$count](bold cyan)";
        deleted = "[✗$count](bold red)";
        ahead = "[⇡$count](bold cyan)";
        behind = "[⇣$count](bold pink)";
        diverged = "[⇕$ahead_count⇣$behind_count](bold orange)";
      };

      # Environments
      nix_shell = {
        format = "[⟨❄⚡ $name⟩]($style) ";
        style = "bold cyan";
      };

      python = {
        format = "[⟨⟪λ⟫ $virtualenv⟩]($style) ";
        style = "bold yellow";
        detect_extensions = [ ];
      };

      nodejs = {
        format = "[⟨⬡⚡ $version⟩]($style) ";
        style = "bold green";
        detect_extensions = [ ];
      };

      rust = {
        format = "[⟨⚙⚡ $version⟩]($style) ";
        style = "bold orange";
      };

      golang = {
        format = "[⟨◈→ $version⟩]($style) ";
        style = "bold cyan";
      };

      java = {
        format = "[⟨☕ $version⟩]($style) ";
        style = "bold red";
      };

      c = {
        format = "[⟨C $version⟩]($style) ";
        style = "bold cyan";
      };

      lua = {
        format = "[⟨◉ $version⟩]($style) ";
        style = "bold purple";
      };

      container = {
        format = "[⟨⬢◢ $name⟩]($style) ";
        style = "bold cyan";
      };

      docker_context = {
        format = "[⟨⬢▸ $context⟩]($style) ";
        style = "bold purple";
        only_with_files = true;
      };

      cmd_duration = {
        format = "[⟨⏱$duration⟩]($style) ";
        style = "bold yellow";
        min_time = 2000;
      };

      # Disable unused
      battery.disabled = true;
      time.disabled = true;
      memory_usage.disabled = true;
      package.disabled = true;
    };
  };
}
