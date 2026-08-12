{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    # Catppuccin Mocha, the palette rofi, waybar and the sway session modules
    # already use.
    themeFile = "Catppuccin-Mocha";
    # environment = {};
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    font = {
      package = pkgs.fantasque-sans-mono;
      name = "Fantasque Sans Mono";
      size = 16;
    };
    keybindings = {
      "ctrl+f>2" = "set_font_size 20";
      "ctrl+shift+o" = "set_background_opacity 1";
      "ctrl+shift+t" = "launch --cwd=current --type=tab";
    };
    settings = {
      # Background comes from the theme (#1E1E2E) rather than a flat black, so
      # the terminal sits in the same family as the bar and the popups. Opaque
      # enough to stay readable over a wallpaper; ctrl+shift+o still snaps it
      # to fully opaque for screen sharing.
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";
      shell = "fish";

      # Breathing room inside the sway border.
      window_padding_width = 8;
      window_margin_width = 0;
      confirm_os_window_close = 0;

      # Only draw the tab bar when there is more than one tab, and make the
      # active one obvious.
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = 2;
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#A6ADC8";
      inactive_tab_background = "#313244";
      inactive_tab_font_style = "normal";

      cursor_shape = "beam";
      cursor_trail = 3;
      cursor_blink_interval = 0;

      # The theme's own selection is subtle to the point of invisible on this
      # background.
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      url_color = "#89B4FA";
      url_style = "curly";

      scrollback_lines = 5000;
      enable_audio_bell = true;
      update_check_interval = 0;
    };
    # extraConfig = ''
    #   '';
  };
}
