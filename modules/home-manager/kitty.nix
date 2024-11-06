{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
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
      background = "#000000"; # permanantely set background to black
      background_opacity = "0.4";
      dynamic_background_opacity = "yes";
      shell = "fish";

      scrollback_lines = 5000;
      enable_audio_bell = true;
      update_check_interval = 0;
    };
    # extraConfig = ''
    #   '';

  };
}
