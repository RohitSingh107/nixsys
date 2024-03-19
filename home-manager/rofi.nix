{ pkgs, inputs, ... }: {


  home.file = {
    ".config/rofi/catppuccin-mocha.rasi" = {
      enable = true;
      # source = (builtins.fetchurl {
      #     url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
      #     sha256 = "042g8gx018y0xlw96ic2kxx76g6ailmdc71wvnln5sf2k7z6rn66";
      #     }); # Gives path to file
      source = inputs.rofi-conf; # Both are equivalent
    };
  };

  programs.rofi = {
    enable = true;
    location = "center";
    theme = "catppuccin-mocha";
    extraConfig = {

      modi = "run,drun,combi";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
      icon-theme = "Tela";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };

  };
}
