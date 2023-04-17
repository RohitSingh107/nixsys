{ config, pkgs, ... }:

{

  imports = [
  ./alacritty.nix
  ./gtk.nix
  ./tmux.nix
  ./mimeApps.nix
  ./neovim.nix
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
  micro
  rnix-lsp
  ];




  



}
