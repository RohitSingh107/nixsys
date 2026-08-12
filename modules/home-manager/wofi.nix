{pkgs, ...}: {
  programs.wofi = {
    enable = true;

    # wofi comes from dnf like the rest of this session's tooling; only
    # ~/.config/wofi/{config,style.css} is managed here.
    package = null;

    settings = {
      show = "drun";
      prompt = "Search";
      width = 620;
      # No height: with lines set, wofi sizes the window to the entries and a
      # height on top of that only fights it.
      lines = 9;
      columns = 1;
      location = "center";

      # Fuzzy and case insensitive, so "fox" finds Firefox.
      matching = "fuzzy";
      insensitive = true;

      allow_images = true;
      image_size = 32;
      allow_markup = true;
      hide_scroll = true;
      no_actions = true;
      gtk_dark = true;

      # Desktop entries with Terminal=true open in the same terminal sway binds
      # to Mod4+Return.
      term = "${pkgs.kitty}/bin/kitty";
    };

    # Catppuccin Mocha again, matching waybar and mako.
    style = ''
      * {
        font-family: "Fantasque Sans Mono", monospace;
        font-size: 16px;
      }

      window {
        background-color: rgba(30, 30, 46, 0.97);
        border: 2px solid #CBA6F7;
        border-radius: 16px;
        color: #CDD6F4;
      }

      #outer-box {
        margin: 14px;
      }

      #input {
        margin-bottom: 12px;
        padding: 8px 12px;
        border: 2px solid #45475A;
        border-radius: 12px;
        background-color: #313244;
        color: #CDD6F4;
      }

      #input:focus {
        border-color: #89B4FA;
      }

      #input image {
        color: #A6ADC8;
      }

      #scroll {
        margin: 0;
      }

      #entry {
        padding: 7px 10px;
        border-radius: 10px;
      }

      #entry:selected {
        background-color: #CBA6F7;
      }

      #entry:selected #text {
        color: #11111B;
        font-weight: bold;
      }

      #text {
        color: #CDD6F4;
        margin-left: 8px;
      }

      #text:selected {
        color: #11111B;
      }

      #img {
        margin-right: 4px;
      }
    '';
  };
}
