{
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod4";

  # Catppuccin Mocha, the palette waybar, mako, wofi, swaylock and kitty use.
  base = "#1E1E2E";
  surface = "#45475A";
  text = "#CDD6F4";
  overlay = "#7F849C";
  mauve = "#CBA6F7";
  red = "#F38BA8";

  # Kept in this repo (wallpapers/), so it lands in the store and the config
  # never points at a path that can go missing. Swap the file to change it.
  wallpaper = ../../wallpapers/dracula-linux.png;
  # Appearance lives in swaylock-fedora.nix (~/.config/swaylock/config).
  lock = "swaylock -f";

  # A dropdown terminal: show the scratchpad copy if it exists, otherwise
  # start it -- swaymsg exits non-zero when no node matches. The window rule
  # below drops it into the scratchpad the moment it appears, and pressing the
  # key again while it is focused hides it, so one key toggles.
  scratchTerm = ''swaymsg '[app_id="scratchterm"] scratchpad show' || ${pkgs.kitty}/bin/kitty --class scratchterm'';

  # grim/slurp/wl-copy/notify-send all come from Fedora; mako (started below)
  # shows the notifications. sway runs these through sh -c, which is bash here,
  # so pipefail is available to keep a cancelled slurp from claiming success.
  screenshot = {
    screen = ''grim - | wl-copy && notify-send -t 2000 "Screenshot" "Copied to clipboard"'';
    region = ''set -o pipefail; slurp | grim -g - - | wl-copy && notify-send -t 2000 "Screenshot" "Region copied to clipboard"'';
    file = ''mkdir -p $HOME/Pictures/Screenshots && f=$HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S').png && grim "$f" && notify-send -t 3000 -i "$f" "Screenshot saved" "$(basename "$f")"'';
  };
in {
  # `wayland.windowManager.sway.xwayland` pulls pkgs.xwayland into the profile
  # with no way to opt out, and ~/.nix-profile/bin sits ahead of /usr/bin in
  # the session PATH -- sway would then launch the Nix Xwayland instead of
  # Fedora's. Emptying the package leaves Fedora's the only one on PATH. If
  # something on this host ever needs a real Xwayland, this is what to drop.
  nixpkgs.overlays = [
    (_final: prev: {
      xwayland = prev.emptyDirectory;
    })
  ];

  wayland.windowManager.sway = {
    enable = true;

    # Sway (and swaybg/swayidle/swaylock/swaynag/waybar/foot/grim/slurp) is
    # installed system-wide with dnf on this host, so home-manager only writes
    # ~/.config/sway/config. `checkConfig` follows `package != null` and turns
    # itself off, since validation needs a sway binary from Nix.
    package = null;

    # Xwayland stays on (Fedora's /usr/bin/Xwayland), and setting this to true
    # is what keeps the config free of any `xwayland` line: sway rejects those
    # on reload whenever they disagree with the running state, so a
    # disable-then-enable pair would pop up a swaynag error on every reload.
    # The package that comes with it is emptied out by the overlay below.
    xwayland = true;

    # Fedora runs dbus-broker, where `systemctl --user import-environment` is
    # enough. The "dbus" implementation would pull in Nix's dbus purely to run
    # dbus-update-activation-environment.
    systemd = {
      enable = true;
      dbusImplementation = "broker";
    };

    config = {
      inherit modifier;

      terminal = "${pkgs.kitty}/bin/kitty";
      # wofi is not part of Fedora's sway package: sudo dnf install wofi
      menu = "wofi --show drun";
      defaultWorkspace = "workspace number 1";

      fonts = {
        names = ["Fantasque Sans Mono" "monospace"];
        size = 11.0;
      };

      gaps = {
        inner = 6;
        outer = 3;
        # Off on purpose: a lone window keeps its gaps and its border, so the
        # focus colour is still visible with one window on the workspace.
        smartGaps = false;
        smartBorders = "off";
      };

      window = {
        border = 2;
        titlebar = false;

        commands = [
          {
            criteria = {app_id = "scratchterm";};
            command = "floating enable, resize set 60 ppt 60 ppt, move position center, move scratchpad, scratchpad show";
          }
        ];
      };

      floating = {
        border = 2;
        titlebar = true;
      };

      focus.followMouse = true;

      colors = {
        focused = {
          border = mauve;
          background = surface;
          text = text;
          indicator = mauve;
          childBorder = mauve;
        };
        focusedInactive = {
          border = surface;
          background = base;
          text = overlay;
          indicator = surface;
          childBorder = surface;
        };
        unfocused = {
          border = base;
          background = base;
          text = overlay;
          indicator = base;
          childBorder = base;
        };
        urgent = {
          border = red;
          background = red;
          text = base;
          indicator = red;
          childBorder = red;
        };
        background = base;
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
          repeat_delay = "250";
          repeat_rate = "30";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "disabled";
          middle_emulation = "enabled";
          click_method = "clickfinger";
        };
      };

      output = {
        "*" = {
          bg = "${wallpaper} fill";
        };
      };

      # Fedora's waybar speaks the swaybar protocol well enough to be launched
      # as sway's bar; it reads its own config from /etc/xdg/waybar.
      bars = [
        {
          command = "waybar";
          statusCommand = null;
        }
      ];

      startup = [
        # GNOME's notification daemon is not around in this session:
        # sudo dnf install mako
        {command = "mako";}
        {
          command = ''swayidle -w timeout 600 "${lock}" timeout 900 "swaymsg 'output * power off'" resume "swaymsg 'output * power on'" before-sleep "${lock}"'';
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+Ctrl+l" = "exec ${lock}";
        # Lock before handing over to systemd rather than trusting swayidle's
        # before-sleep hook, so the screen is covered even if swayidle died.
        "${modifier}+Ctrl+s" = "exec ${lock} && systemctl suspend";
        "${modifier}+grave" = "exec ${scratchTerm}";
        # nautilus comes from Fedora's GNOME install.
        "${modifier}+Shift+Return" = "exec nautilus";

        # Screenshots. This laptop has no Print key, so p (for print) carries
        # the same three actions; Mod+Shift+s is there for Windows muscle
        # memory. The Print variants still work on an external keyboard.
        "${modifier}+p" = "exec ${screenshot.screen}";
        "${modifier}+Shift+p" = "exec ${screenshot.region}";
        "${modifier}+Shift+s" = "exec ${screenshot.region}";
        "${modifier}+Ctrl+p" = "exec ${screenshot.file}";
        "Print" = "exec ${screenshot.screen}";
        "Shift+Print" = "exec ${screenshot.region}";
        "${modifier}+Print" = "exec ${screenshot.file}";

        # Audio / media (pactl and playerctl come from Fedora).
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # Needs: sudo dnf install brightnessctl
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };
    };
  };
}
