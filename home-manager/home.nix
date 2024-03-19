# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ./alacritty.nix
    ./kitty.nix
    ./fish.nix
    ./gtk.nix
    ./tmux.nix
    ./mimeApps.nix
    ./starship.nix
    ./vscode.nix
    ./chromium.nix
    # ./picom.nix
    ./nvim
    ./xmobar
    ./xmonad
    ./firefox
    ./qtile
    ./lf
    ./hyprland.nix
    ./accounts.nix
    ./qt.nix
    ./bash.nix
    ./rofi.nix
    ./waybar.nix
    ./wlogout.nix
    ./swaylock.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "rohits";
    homeDirectory = "/home/rohits";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    packages = with pkgs; [
      # brave
      bitwarden
      neofetch
      discord
      killall
      fantasque-sans-mono # Maybe should not be here
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      dmenu
      pavucontrol
      xclip
      wl-clipboard
      xdotool
      whatsapp-for-linux
      brightnessctl
      gnome.gnome-tweaks
      gnomeExtensions.dash-to-dock
      exercism
      ranger
      screenfetch
      cowsay
      google-chrome

      # Network
      networkmanagerapplet

      # Process monitor
      procs
      mission-center

      ## Disk
      filelight
      gdu

      ## Sound
      pulseaudio

      ## Notifications
      dunst
      libnotify

      ## Wayland only
      clipman
      swaybg
      swappy
      grim
      slurp
    ];

    file = {
      ".config/wallpapers".source = config.lib.file.mkOutOfStoreSymlink ../wallpapers;
    };

  };


  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat = {
      enable = true;
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--icons"
      ];
    };

    # doom-emacs = {
    #   enable = true;
    #   doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
    #   # and packages.el files
    # };



    htop = {
      enable = true;
    };



    git = {
      enable = true;
      userName = "Rohit Singh";
      userEmail = "RohitSinghEmail@protonmail.com";
    };


    micro = {
      enable = true;
      settings = {
        colorscheme = "simple";
      };
    };

    feh = {
      enable = true;
      keybindings = {
        prev_img = [
          "h"
          "Left"
        ];
        zoom_in = "plus";
        zoom_out = "minus";
      };
    };

    direnv = {
      enable = true;
      # enableBashIntegration = true;
      # enableFishIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };



  };



  services = {
    network-manager-applet.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };

    blueman-applet = {
      enable = true;
    };

    flameshot = {
      enable = false;
      # settings = {
      #   General = {
      #     showStartupLaunchMessage = true;
      #     # showDesktopNotification = true;
      #     savePath = "/home/rohits/Pictures";
      #   };
      # };
    };
  };







  fonts = {
    fontconfig = {
      enable = true;
    };
  };


  # wayland = {
  #   windowManager = {
  #     hyprland = {
  #       enable = true;
  #     };
  #   };
  # };
  #


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}
