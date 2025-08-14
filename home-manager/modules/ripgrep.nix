{ config, ... }:
{
  config = {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--pretty"
        "--max-columns=150"
        "--max-columns-preview"
        "--glob=!.git/*"
      ];
    };
  };
}
