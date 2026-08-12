{...}: let
  # Catppuccin Mocha, the same palette waybar-sway.nix uses, so notifications
  # read as part of the bar rather than as a stray GTK window.
  base = "#1E1E2EF7";
  surface = "#313244";
  text = "#CDD6F4";
  subtext = "#A6ADC8";
  mauve = "#CBA6F7";
  blue = "#89B4FA";
  red = "#F38BA8";
in {
  services.mako = {
    enable = true;

    # mako is installed with dnf and started from sway's config, so this only
    # writes ~/.config/mako/config -- `makoctl reload` picks it up on switch.
    package = null;

    settings = {
      font = "Fantasque Sans Mono 12";
      width = 380;
      height = 160;
      margin = 8;
      padding = "12,16";
      border-size = 2;
      border-radius = 12;
      background-color = base;
      text-color = text;
      border-color = mauve;
      progress-color = "over ${surface}";

      # waybar reserves its own space at the top, so mako lands just below it.
      anchor = "top-right";
      layer = "top";
      outer-margin = "0,10";

      max-visible = 5;
      default-timeout = 5000;

      icon-location = "left";
      max-icon-size = 64;
      icon-border-radius = 8;

      markup = true;
      format = "<b>%s</b>\\n%b";
      text-alignment = "left";

      "urgency=low" = {
        border-color = blue;
        text-color = subtext;
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = mauve;
      };

      # Critical stays until it is dismissed.
      "urgency=critical" = {
        border-color = red;
        default-timeout = 0;
      };
    };
  };
}
