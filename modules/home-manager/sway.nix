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
in {
  wayland.windowManager.sway = {
    enable = true;

    # Sway (and swaybg/swayidle/swaylock/swaynag/waybar/foot/grim/slurp) is
    # installed system-wide with dnf on this host, so home-manager only writes
    # ~/.config/sway/config. `checkConfig` follows `package != null` and turns
    # itself off, since validation needs a sway binary from Nix.
    package = null;

    # Keeps pkgs.xwayland out of the profile -- Fedora ships Xwayland already.
    # The module emits "xwayland disable" for this, which extraConfig (appended
    # last) flips back on; the point is the package, not the feature.
    xwayland = false;

    # Fedora runs dbus-broker, where `systemctl --user import-environment` is
    # enough. The "dbus" implementation would pull in Nix's dbus purely to run
    # dbus-update-activation-environment.
    systemd = {
      enable = true;
      dbusImplementation = "broker";
    };

    extraConfig = ''
      # Re-enable Xwayland (see the xwayland option above); /usr/bin/Xwayland.
      xwayland enable
    '';

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
          bg = "${background} solid_color";
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
          command = ''swayidle -w timeout 600 "swaylock -f -c ${lib.removePrefix "#" background}" timeout 900 "swaymsg 'output * power off'" resume "swaymsg 'output * power on'" before-sleep "swaylock -f -c ${lib.removePrefix "#" background}"'';
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+Ctrl+l" = "exec swaylock -f -c ${lib.removePrefix "#" background}";

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
