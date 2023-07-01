{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    theme = "Dracula";
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
    };
    settings = {
      scrollback_lines = 5000;
      enable_audio_bell = true;
      update_check_interval = 0;
    };
    extraConfig = ''
      '';

  };
}
