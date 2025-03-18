{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      inter
      roboto
      open-sans
      source-serif-pro
      merriweather
      fira-code
      jetbrains-mono
      noto-fonts-emoji
      twemoji-color-font
      font-awesome
      liberation_ttf
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Source Serif Pro" "Merriweather" "DejaVu Serif" ];
        sansSerif = [ "Inter" "Roboto" "Open Sans" "DejaVu Sans" ];
        monospace = [ "Fira Code" "JetBrains Mono" "DejaVu Sans Mono" ];
        emoji = [ "Noto Color Emoji" "Twemoji" ];
      };
    };
  };
}