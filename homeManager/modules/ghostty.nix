{
  userConfig,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.lib.nixGL) wrap;
in
{
  programs.ghostty = lib.mkIf userConfig.machine.workstation {
    enable = true;
    package = wrap pkgs.ghostty;
    enableZshIntegration = true;

    settings = {
      font-family = "";
      font-size = 12;
      theme = "catppuccin-mocha"; # Belafonte Night
      mouse-hide-while-typing = true;
      gtk-titlebar = false;
      background-opacity = 0.85;
      background-blur-radius = 20;
      macos-option-as-alt = true;
      macos-non-native-fullscreen = "visible-menu";

      keybind = [
        "alt+c=copy_to_clipboard"
        "alt+v=paste_from_clipboard"
        "alt+shift+c=copy_to_clipboard"
        "alt+shift+v=paste_from_clipboard"
        "alt+zero=reset_font_size"
        "alt+q=quit"
        "alt+shift+comma=reload_config"
        "alt+k=clear_screen"
        "alt+n=new_window"
        "alt+w=close_surface"
        "alt+shift+w=close_window"
        "alt+t=new_tab"
        "alt+shift+left_bracket=previous_tab"
        "alt+shift+right_bracket=next_tab"
        "alt+d=new_split:right"
        "alt+shift+d=new_split:down"
        "alt+right_bracket=goto_split:next"
        "alt+left_bracket=goto_split:previous"
      ];
    };
  };
}
