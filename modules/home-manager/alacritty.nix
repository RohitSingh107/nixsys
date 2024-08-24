{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      # font = rec {
      #   normal.family = "Fantasque Sans Mono";
      #   bold.family = "Fantasque Sans Mono";
      #   size = 12;
      # };
      window = {
        # opacity = 0.6;
        padding = {
          x = 8;
          y = 2;
        };
        dynamic_padding = true;
        decorations = "full";
        dynamic_title = true;
        decorations_theme_variant = "Dark";

      };

      cursor.style = "Underline";
      save_to_clipboard = true;
      draw_bold_text_with_bright_colors = true;

      shell.program = "fish";


      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      offset = {
        # Positioning
        x = -1;
        y = 0;
      };
      # colors = {
      #   primary = {
      #     background = "#282a36";
      #     foreground = "#f8f8f2";
      #   };
      #
      #   normal = {
      #     black = "#000000";
      #     red = "#ff5555";
      #     green = "#50fa7b";
      #     yellow = "#f1fa8c";
      #     blue = "#caa9fa";
      #     magenta = "#ff79c6";
      #     cyan = "#8be9fd";
      #     white = "#bfbfbf";
      #   };
      #
      #   bright = {
      #
      #     black = "#575b70";
      #     red = "#ff6e67";
      #     green = "#5af78e";
      #     yellow = "#f4f99d";
      #     blue = "#caa9fa";
      #     magenta = "#ff92d0";
      #     cyan = "#9aedfe";
      #     white = "#e6e6e6";
      #
      #   };
      # };
    };
  };
}
