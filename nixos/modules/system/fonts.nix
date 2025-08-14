{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Mono space
      nerd-fonts.jetbrains-mono

      # Other regular fonts
      inter
      liberation_ttf

      # Emoji & Symbols
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
      };

      defaultFonts = {
        sansSerif = [ "Inter" ];
        serif = [ "Liberation Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
