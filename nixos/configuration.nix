# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Enable Power Management
    ./laptop-battery.nix
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
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;

    trusted-users = ["root" "rohits"];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;

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

    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };

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
        # version = 2;
        device = "nodev";
        useOSProber = false;
        efiSupport = true;

        theme = pkgs.sleek-grub-theme.override {
          withBanner = "Hello Rohit";
          withStyle = "dark"; # one of "white" "dark" "orange" "bigSur"
        };
        # splashImage = ../wall/grub.png;

        extraEntries = ''

          menuentry "Reboot" {
           reboot
          }

          menuentry "Shut Down" {
           halt
          }


          function load_video {
            if [ x$feature_all_video_module = xy ]; then
              insmod all_video
            else
              insmod efi_gop
              insmod efi_uga
              insmod ieee1275_fb
              insmod vbe
              insmod vga
              insmod video_bochs
              insmod video_cirrus
            fi
          }



          menuentry 'Garuda Linux' --class garuda --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-92f6319f-6ea7-4779-ae48-2a6646f0fc86' {
            load_video
            set gfxpayload=keep
            insmod gzio
            insmod part_gpt
            insmod btrfs
            search --no-floppy --fs-uuid --set=root 92f6319f-6ea7-4779-ae48-2a6646f0fc86
            echo	'Loading Linux linux-zen ...'
            linux	/@/boot/vmlinuz-linux-zen root=UUID=92f6319f-6ea7-4779-ae48-2a6646f0fc86 rw rootflags=subvol=@  quiet splash rd.udev.log_priority=3 vt.global_cursor_default=0 loglevel=3 ibt=off
            echo	'Loading initial ramdisk ...'
            initrd	/@/boot/amd-ucode.img /@/boot/initramfs-linux-zen.img
          }


        '';
      };

      timeout = 5;
    };
  };

  # Set your time zone.
  time = {
    timeZone = "Asia/Kolkata";
  };

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    rohits = {
      isNormalUser = true;
      description = "Rohit Singh";
      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];
      extraGroups = ["networkmanager" "wheel" "libvirtd" "docker"];
      packages = with pkgs; [
        #  thunderbird
      ];
    };
  };

  # # This setups a SSH server. Very important if you're setting up a headless system.
  # # Feel free to remove if you don't need it.
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     # Forbid root login through SSH.
  #     PermitRootLogin = "no";
  #     # Use keys only. Remove if you want to SSH using password (not recommended)
  #     PasswordAuthentication = false;
  #   };
  # };

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
    fstrim.enable = true;

    blueman = {
      enable = true;
    };

    displayManager.autoLogin = {
      # Enable automatic login for the user.
      enable = true;
      user = "rohits";
    };

    xserver = {
      videoDrivers = ["modesetting"];

      # Configure keymap in X11
      xkb = {
        variant = "";
        layout = "us";
      };

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
          banner = "Welocome to Rohit's NixOS system";
        };
      };

      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };

        qtile = {
          enable = false;
          backend = "x11";
          extraPackages = python3Packages:
            with python3Packages; [
              qtile-extras
            ];
          # configFile = ./qtile/config.py;
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
      enable = false;
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
  };

  # Hyprland
  # programs.sway.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      libvdpau
      amdvlk
      vaapiVdpau
      libvdpau-va-gl
      # AMD ROCm OpenCL runtime
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;

      daemon = {
        settings = {
          data-root = "/home/rohits/mydata/docker-data/docker-root";
        };
      };

      rootless = {
        enable = false;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "/home/rohits/mydata/docker-data/docker-root";
        };
      };

      autoPrune = {
        enable = false;
      };
    };
  };

  systemd = {
    services = {
      # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    firefox
    git
    neovim
    gparted
  ];

  environment.variables = {
    EDITOR = "nvim";
    LC_ALL = "en_IN.UTF-8";
  };
  #
  environment.sessionVariables = {
    # Hints electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    NIXOS_CONFIG_DIR = "/home/rohits/nixsys";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
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

  ## Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "bredr";
      };
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
    jack.enable = true;

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
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
