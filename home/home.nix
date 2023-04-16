{ config, pkgs, ... }:

{

  imports = [
  ./alacritty.nix
  ];

  home.username = "rohits";
  home.homeDirectory = "/home/rohits";

  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Rohit Singh";
    userEmail = "RohitSinghEmail@protonmail.com";
  };
  home.packages = with pkgs; [
  alacritty
  fish
  htop
  gdu
  bitwarden
  bitwarden-cli
  neofetch
  gnomeExtensions.dash-to-dock
  discord
  fantasque-sans-mono
  ];




gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      #name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-gtk.override {
      #  accents = ["mauve"];
      #  size = "compact";
      #  variant = "mocha";
      #};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      #name = "JetBrains Mono Medium";
      name = "FiraCode Nerd Font Mono Medium";
    };                                        # Cursor is declared under home.pointerCursor
  };
}
