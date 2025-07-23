{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    initContent = builtins.readFile ./zshrc;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "l" = "lsd -l --group-dirs first --color auto";
      "ll" =
        "lsd -l --header --classify --size short --group-dirs first --date '+%Y-%m-%d %H:%M' --all --color auto";
      "la" = "lsd -a --group-dirs first --color auto";
      "lt" = "lsd --tree --depth 2 --group-dirs first --color auto";
      "lta" = "lsd --tree --depth 2 -a --group-dirs first --color auto";
      "ltg" = "lsd --tree --depth 2 --ignore-glob '.git' --group-dirs first --color auto";
      "g" = "git";
      "ga" = "git add";
      "gs" = "git status -sb";
      "gc" = "git commit";
      "gcm" = "git commit -m";
      "gca" = "git commit --amend";
      "gco" = "git checkout";
      "gd" = "git diff";
      "gds" = "git diff --staged";
      "gp" = "git push";
      "gpr" = "git pull --rebase";
      "gl" =
        "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      "df" = "df -h";
      "du" = "du -h";
      "free" = "free -h";
      "ps" = "ps auxf";
      "top" = "htop";
      "ip" = "ip -color=auto";
      "diff" = "diff --color=auto";
      "find" = "fd";
      "mkdir" = "mkdir -pv";
      "ping" = "ping -c 5";
      "wget" = "wget -c";
      "ports" = "ss -tulpn";
      "rm" = "rm -Iv --one-file-system";
      "cp" = "cp -iv";
      "mv" = "mv -iv";
      "ln" = "ln -iv";
      "v" = "nvim";
      "vi" = "nvim";
      "cl" = "clear";
      "x" = "exit";
      "nc" = "nix-collect-garbage";
      "home-check" = "journalctl -u home-manager-$USER.service";
      "hm" = "home-manager";
      "ts" = "date '+%Y-%m-%d %H:%M:%S'";
      "reload" = "source ~/.zshrc";
      "k" = "kubectl";
      "grep" = "rg";
      "r" = "R --vanilla";
      "rscript" = "Rscript";
      "rdev" = "R -q --no-save";
      "rlint" = "Rscript -e 'lintr::lint_dir()'";
      "rfmt" = "Rscript -e 'styler::style_dir()'";
    };
  };
}
