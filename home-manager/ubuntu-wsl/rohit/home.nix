{ config, pkgs, outputs, ... }:

{



  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # ../../../modules/home-manager/alacritty.nix
    ../../../modules/home-manager/kitty.nix
    ../../../modules/home-manager/fish.nix
    # ../../../modules/home-manager/tmux.nix
    ../../../modules/home-manager/starship.nix
    ../../../modules/home-manager/nvim
    # ../../../modules/home-manager/chromium.nix
    # ../../../modules/home-manager/firefox
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



  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rohit";
  home.homeDirectory = "/home/rohit";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rohit/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
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
      icons = "auto";
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
      enable = false;
      userName = "Rohit Singh";
      userEmail = "RohitSinghEmail@protonmail.com";
    };
    git-credential-oauth.enable = true;

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
      enable = false;
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
      enable = false;
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
}
