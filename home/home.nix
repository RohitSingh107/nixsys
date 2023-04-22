{ config, pkgs, ... }:

{

  imports = [
    ./alacritty.nix
    ./fish.nix
    ./gtk.nix
    ./tmux.nix
    ./mimeApps.nix
    ./neovim.nix
    ./starship.nix
    ./xmobar/xmobar.nix
  ];

  services.network-manager-applet.enable = true;

  home.username = "rohits";
  home.homeDirectory = "/home/rohits";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  programs.bat = {
    enable = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = false;
    git = true;
    icons = true;
    extraOptions = [
      "--color=always"
      "--group-directories-first"
      "--header"
      "--icons"
    ];
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
    # and packages.el files
  };



  programs.htop = {
    enable = true;
  };



  # Let Home Manager install and manage itself.
  programs.git = {
    enable = true;
    userName = "Rohit Singh";
    userEmail = "RohitSinghEmail@protonmail.com";
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad/xmonad.hs;
  };

  home.packages = with pkgs; [
    gdu
    bitwarden
    bitwarden-cli
    neofetch
    gnomeExtensions.dash-to-dock
    discord
    fantasque-sans-mono
    micro
    rnix-lsp
    nerdfonts
    feh
    trayer # For Xmonad/Xmobar tray
  ];








}
