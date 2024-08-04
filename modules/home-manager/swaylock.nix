{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = "~/.config/wallpapers/dracula-nixos.png";
      indicator-caps-lock = true;
      font = "FiraSans";
      indicator-radius = 125;
      line-color = "#3b4252";
      text-color = "#d8dee9";
      inside-color = "#2e344098";
      inside-ver-color = "#5e81ac";
      line-ver-color = "#5e81ac";
      ring-ver-color = "#5e81ac98";
      ring-color = "#4c566a";
      key-hl-color = "#5e81ac";
      separator-color = "#4c566a";
      layout-text-color = "#eceff4";
      line-wrong-color = "#d08770";
      show-failed-attempts = true;
      # screenshots = true;
      # time-effects = true;
      # fade-in = 3;
      # grace = 30;
    };
  };
}
