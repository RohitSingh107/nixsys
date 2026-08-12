{
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod4";

  # Dracula, to match the kitty theme used on the same hosts.
  background = "#282a36";
  currentLine = "#44475a";
  foreground = "#f8f8f2";
  comment = "#6272a4";
  purple = "#bd93f9";
  red = "#ff5555";

  # Kept in this repo (wallpapers/), so it lands in the store and the config
  # never points at a path that can go missing. Swap the file to change it.
  wallpaper = ../../wallpapers/dracula-linux.png;
  lock = "swaylock -f -i ${wallpaper} -s fill";
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
        smartGaps = true;
        smartBorders = "on";
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = true;
      };

      focus.followMouse = true;

      colors = {
        focused = {
          border = purple;
          background = currentLine;
          text = foreground;
          indicator = purple;
          childBorder = purple;
        };
        focusedInactive = {
          border = currentLine;
          background = background;
          text = comment;
          indicator = currentLine;
          childBorder = currentLine;
        };
        unfocused = {
          border = background;
          background = background;
          text = comment;
          indicator = background;
          childBorder = background;
        };
        urgent = {
          border = red;
          background = red;
          text = foreground;
          indicator = red;
          childBorder = red;
        };
        inherit background;
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

        # Screenshots (grim/slurp/wl-clipboard come from Fedora).
        "Print" = "exec grim - | wl-copy";
        "Shift+Print" = "exec slurp | grim -g - - | wl-copy";
        "${modifier}+Print" = "exec mkdir -p $HOME/Pictures/Screenshots && grim $HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S').png";

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
