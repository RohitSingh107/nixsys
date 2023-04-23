{ config, pkgs, ... }:

{

  imports = [
    ./alacritty.nix
    ./fish.nix
    ./gtk.nix
    ./tmux.nix
    ./mimeApps.nix
    ./starship.nix
    ./nvim
    ./xmobar
  ];


  home = {
    username = "rohits";
    homeDirectory = "/home/rohits";
    stateVersion = "22.11";

    packages = with pkgs; [
      gdu
      bitwarden
      bitwarden-cli
      neofetch
      gnomeExtensions.dash-to-dock
      discord
      fantasque-sans-mono
      micro
      rnix-lsp
      nerdfonts # Maybe should not be here
      feh
      trayer # For Xmonad/Xmobar tray
      dmenu
      flameshot
      pavucontrol
      xclip
      wl-clipboard

    ];


    file = {
      ".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../wall;
    };

  };

  services = {
    network-manager-applet.enable = true;
  };



  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat = {
      enable = true;
    };

    exa = {
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

    doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
      # and packages.el files
    };



    htop = {
      enable = true;
    };



    git = {
      enable = true;
      userName = "Rohit Singh";
      userEmail = "RohitSinghEmail@protonmail.com";
    };
  };




  fonts = {
    fontconfig = {
      enable = true;
    };
  };



  xsession = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad/xmonad.hs;
      };
    };


  };

}
