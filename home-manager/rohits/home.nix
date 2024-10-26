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

    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/fish.nix
    # ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/xdg.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/chromium.nix
    # ../../modules/home-manager/picom.nix
    ../../modules/home-manager/nvim
    ../../modules/home-manager/xmobar
    ../../modules/home-manager/xmonad
    ../../modules/home-manager/firefox
    ../../modules/home-manager/lf
    ../../modules/home-manager/hyprland.nix
    # ../../modules/home-manager/accounts.nix
    # ../../modules/home-manager/qt.nix
    ../../modules/home-manager/bash.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/wlogout.nix
    ../../modules/home-manager/swaylock.nix
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

  home = {
    username = "rohits";
    homeDirectory = "/home/rohits";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    packages = with pkgs; [
      # brave
      libsecret
      neofetch
      discord
      killall
      fantasque-sans-mono # Maybe should not be here
      (nerdfonts.override {fonts = ["FiraCode"];})
      dmenu
      pavucontrol
      xclip
      xdotool
      whatsapp-for-linux
      brightnessctl
      gnome.gnome-tweaks
      gnomeExtensions.dash-to-dock
      exercism
      screenfetch
      cowsay
      alejandra
      guake
      tilda
      # google-chrome

      # Files Operations
      meld

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
      wl-clipboard

      ## Containers/VM
      distrobox
      distrobox-tui
    ];

    file = {
      ".config/wallpapers".source = config.lib.file.mkOutOfStoreSymlink ../../wallpapers;
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bat = {
      enable = true;
    };

    ripgrep = {
      enable = true;
      # package = pkgs.ripgrep-all;
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

    mpv = {
      enable = true;
      config = {
        vo = "gpu";
        hwdec= "auto-safe";
        profile= "gpu-hq";
        gpu-context = "wayland";
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
      enableBashIntegration = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    ranger = {
      enable = true;
      mappings = {
        Q = "quitall";
        q = "quit";
        e = "edit";
        gpc = "cd ~/mydata/code/practice-code";
        gmd = "cd ~/mydata";
        gt = "cd ~/mydata/tmp";
      };

      settings = {
        preview_images = true;
        preview_images_method = "kitty";
        show_hidden = true;
        status_bar_on_top = true;
        draw_borders = "outline";
        display_size_in_status_bar = false;
        hostname_in_titlebar = false;
      };

      extraConfig = ''
        # == Local Options # local options that only affect a single directory.
        setlocal path=~/Downloads sort mtime
      '';
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

    copyq.enable = true;
  };


  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
