{ pkgs, ... }: {


  programs.rofi = {
    enable = true;
    location = "center";
    theme = "dracula";
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
