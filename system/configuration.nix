# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # systemd-boot = {
      #   enable = false;
      # };



      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;

        theme = pkgs.nixos-grub2-theme;
        splashImage = ../wall/grub.jpg;

        extraEntries = ''

          menuentry "Reboot" {
	          reboot
          }

          menuentry "Shut Down" {
	          halt
          }
          '';
      };

      timeout = 5;

    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager = {
      enable = true;
    };
  };


  # Set your time zone.
  time = {
    timeZone = "Asia/Kolkata";
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_IN";

    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };


  services = {

    xserver = {

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";

      # Enable the X11 windowing system.
      enable = true;


      desktopManager = {

        # Enable the GNOME Desktop Environment.
        gnome = {
          enable = true;
        };
      };

      displayManager = {
        # Enable the GNOME Desktop Environment.
        gdm = {
          enable = true;
        };
        autoLogin = {
          # Enable automatic login for the user.
          enable = true;
          user = "rohits";
        };
      };

      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };



      libinput = {
        # Enable touchpad support (enabled default in most desktopManager).
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
        mouse = {
          naturalScrolling = true;
        };
      };


      # Extra Optional Settings to prevent screen timeout 
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
        '';

    };

    printing = {
      # Enable CUPS to print documents.
      enable = true;
    };




  };

  users.users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    rohits = {
      isNormalUser = true;
      description = "Rohit Singh";
      extraGroups = [ "networkmanager" "wheel" ];
      # extraGroups = [ "networkmanager" "wheel" "audio" "video" "ip" "scanner" "camera" "kvm" "libvirtd" "plex" ];
      packages = with pkgs; [
        #  thunderbird
      ];
    };
  };

  systemd = {
    services = {
      # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };


  nixpkgs = {
    config = {
      # Allow unfree packages
      allowUnfree = true;
    };
  };

  environment = {

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      firefox
      git
      neovim
    ];

    variables = {
      EDITOR = "nvim";
      LC_ALL = "en_IN.UTF-8";
      NIXOS_CONFIG_DIR = "/home/rohits/nixsys";
    };



  };





  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      corefonts
      noto-fonts-emoji
      liberation_ttf
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
      fira-code
      fira-code-symbols
    ];

  };



  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };







  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?



}
