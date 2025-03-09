{ config, pkgs, ... }:

let
  nordTheme = ''
    foreground            #D8DEE9
    background            #2E3440
    selection_foreground  #000000
    selection_background  #FFFACD
    url_color             #0087BD
    cursor                #81A1C1

    # black
    color0   #3B4252
    color8   #4C566A

    # red
    color1   #BF616A
    color9   #BF616A

    # green
    color2   #A3BE8C
    color10  #A3BE8C

    # yellow
    color3   #EBCB8B
    color11  #EBCB8B

    # blue
    color4  #81A1C1
    color12 #81A1C1

    # magenta
    color5   #B48EAD
    color13  #B48EAD

    # cyan
    color6   #88C0D0
    color14  #8FBCBB

    # white
    color7   #E5E9F0
    color15  #ECEFF4
  '';
in
{
  programs.kitty = {
    enable = true;
    settings = {
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      font_size = "13.0";

      foreground = "#c0b18b";
      background = "#262626";
      background_opacity = "0.9";
      selection_foreground = "#2f2f2f";
      selection_background = "#d75f5f";
      cursor = "#8fee96";
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = "9000";
      scrollback_pager = "less +G -R";
      wheel_scroll_multiplier = "5.0";
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      mouse_hide_wait = "0.5";
      enabled_layouts = "*";
      repaint_delay = "10";
      input_delay = "3";
      visual_bell_duration = "0.0";
      enable_audio_bell = "yes";
      open_url_modifiers = "ctrl+shift";
      open_url_with = "default";
      term = "xterm-kitty";
      window_border_width = "0";
      window_margin_width = "15";
      active_border_color = "#ffffff";
      inactive_border_color = "#cccccc";
      hide_window_decorations = "yes";
      macos_option_as_alt = "no";
      remember_window_size = "yes";
      confirm_os_window_close = "0";
      macos_titlebar_color = "background";
    };
    extraConfig = nordTheme;
  };
}

