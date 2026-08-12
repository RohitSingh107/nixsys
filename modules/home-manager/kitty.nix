{pkgs, ...}: let
  # Everything that changes with the palette lives in one of these; flip the
  # `theme` binding below to switch. Dracula is what this module used before
  # the move to Catppuccin, kept whole so going back is a one-line edit.
  themes = {
    catppuccin-mocha = {
      file = "Catppuccin-Mocha";
      settings = {
        # No `background`: the theme's own #1E1E2E base is the point, and
        # setting one here would paint over it.
        background_opacity = "0.85";

        active_tab_foreground = "#11111B";
        active_tab_background = "#CBA6F7";
        inactive_tab_foreground = "#A6ADC8";
        inactive_tab_background = "#313244";

        # Mocha's own selection is subtle to the point of invisible at this
        # opacity.
        selection_foreground = "#1E1E2E";
        selection_background = "#F5E0DC";
        url_color = "#89B4FA";
      };
    };

    dracula = {
      file = "Dracula";
      settings = {
        background = "#000000"; # permanantely set background to black
        background_opacity = "0.4";

        active_tab_foreground = "#282A36";
        active_tab_background = "#BD93F9";
        inactive_tab_foreground = "#6272A4";
        inactive_tab_background = "#44475A";

        selection_foreground = "#282A36";
        selection_background = "#F8F8F2";
        url_color = "#8BE9FD";
      };
    };
  };

  # <-- the switch
  theme = themes.catppuccin-mocha;
in {
  programs.kitty = {
    enable = true;
    themeFile = theme.file;
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
    settings =
      theme.settings
      // {
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
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";

        cursor_shape = "beam";
        cursor_trail = 3;
        cursor_blink_interval = 0;

        url_style = "curly";

        scrollback_lines = 5000;
        enable_audio_bell = true;
        update_check_interval = 0;
      };
    # extraConfig = ''
    #   '';
  };
}
