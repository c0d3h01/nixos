{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      serif = [
        "Noto Serif"
      ];
      sansSerif = [
        "Noto Sans"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
      ];
      emoji = [
        "Noto Color Emoji"
      ];
    };
  };
}
