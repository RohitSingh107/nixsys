{
  pkgs,
  lib,
  ...
}: {
  # Waybar variant for the Fedora sway session: the bar itself comes from dnf
  # (sway.nix launches /usr/bin/waybar through the sway bar block), so this
  # module only writes ~/.config/waybar/{config,style.css}. The hyprland hosts
  # use waybar.nix instead -- its workspace modules and helpers are Hyprland
  # and Nix specific.
  programs.waybar = {
    enable = true;

    # home-manager has no `package = null` here the way sway does, so point it
    # at an empty derivation: nothing lands in the profile and Fedora's
    # /usr/bin/waybar stays the only waybar on PATH.
    package = pkgs.emptyDirectory;

    # Leave systemd integration off -- it would build a user unit around the
    # empty package above. sway starts the bar instead.
    systemd.enable = false;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # 38 is the minimum the modules below need; smaller and waybar warns
        # and grows the bar anyway.
        height = 38;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;

        modules-left = ["custom/launcher" "sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = [
          "tray"
          "cpu"
          "memory"
          "disk"
          "backlight"
          "pulseaudio#audio"
          "pulseaudio#microphone"
          "network#wlo1"
          "battery"
          "clock"
          "custom/powermenu"
        ];

        "custom/launcher" = {
          format = "";
          # wofi is not part of Fedora's sway package: sudo dnf install wofi
          on-click = "wofi --show drun";
          tooltip = false;
        };

        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "α";
            "2" = "β";
            "3" = "γ";
            "4" = "δ";
            "5" = "ε";
            "6" = "ζ";
            "7" = "η";
            "8" = "θ";
            "9" = "ι";
            "10" = "κ";
            "default" = "α";
          };
        };

        "sway/mode" = {
          format = "{}";
          tooltip = false;
        };

        "sway/window" = {
          format = " {title} ";
          max-length = 40;
          all-outputs = false;
        };

        tray = {
          spacing = 10;
        };

        cpu = {
          interval = 5;
          format = " {usage}%";
          on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.htop}/bin/htop";
          tooltip = false;
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}GB ({percentage}%)";
          on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.htop}/bin/htop";
          tooltip = false;
        };

        disk = {
          interval = 30;
          format = " {percentage_free}% free";
          tooltip = false;
        };

        # Needs: sudo dnf install brightnessctl
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [""];
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
          tooltip = false;
        };

        "pulseaudio#audio" = {
          format = "{icon} {volume}%";
          format-bluetooth = " {icon} {volume}%";
          format-bluetooth-muted = "  {volume}%";
          format-muted = " {volume}%";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            default = ["" "" ""];
          };
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
          tooltip = false;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = " {volume}%";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +1%";
          on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -1%";
          max-volume = 100;
          tooltip = false;
        };

        "network#wlo1" = {
          interval = 10;
          interface = "wlo1";
          format-wifi = " {signalStrength}%";
          format-disconnected = "";
          format-alt = " {essid} | {ipaddr}/{cidr}";
          tooltip = false;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };

        clock = {
          interval = 1;
          format = " {:%I:%M %p}";
          format-alt = "{:%A, %B %d | %I:%M:%S %p}";
        };

        # swaynag ships with Fedora's sway, so the power menu needs nothing extra.
        "custom/powermenu" = let
          # Same lock screen as sway.nix binds to Mod4+Ctrl+l.
          swaylock = "swaylock -f";
        in {
          format = "";
          on-click = "swaynag -t warning -m 'Power' -b 'Lock' '${swaylock}' -b 'Suspend' '${swaylock} && systemctl suspend' -b 'Logout' 'swaymsg exit' -b 'Reboot' 'systemctl reboot' -b 'Shutdown' 'systemctl poweroff'";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: "Fantasque Sans Mono", "Font Awesome 6 Free", "Font Awesome 6 Brands", monospace;
        font-size: 14px;
      }

      @define-color red      #F38BA8;
      @define-color maroon   #EBA0AC;
      @define-color peach    #FAB387;
      @define-color yellow   #F9E2AF;
      @define-color green    #A6E3A1;
      @define-color teal     #94E2D5;
      @define-color sky      #89DCEB;
      @define-color blue     #89B4FA;
      @define-color mauve    #CBA6F7;
      @define-color pink     #F5C2E7;
      @define-color text     #CDD6F4;
      @define-color crust    #11111B;
      @define-color base-transparent rgba(30, 30, 46, 0.8);

      window#waybar {
        background-color: @base-transparent;
        color: @text;
        border-radius: 20px;
      }

      #workspaces button {
        background-color: transparent;
        color: @text;
        padding: 1px 8px;
        margin: 5px 2px;
        border-radius: 20px;
        transition-property: background-color;
        transition-duration: 0.3s;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: @blue;
        color: @crust;
      }

      #workspaces button.focused,
      #workspaces button.visible {
        background-color: @green;
        color: @crust;
      }

      #workspaces button.urgent {
        background-color: @red;
        color: @crust;
      }

      #custom-launcher,
      #mode,
      #window,
      #tray,
      #cpu,
      #memory,
      #disk,
      #backlight,
      #pulseaudio.audio,
      #pulseaudio.microphone,
      #network,
      #battery,
      #clock,
      #custom-powermenu {
        color: @crust;
        padding: 1px 8px;
        margin: 5px 2px;
        border-radius: 20px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      /* If a module is the leftmost one, omit its left margin */
      .modules-left > widget:first-child > #workspaces,
      .modules-left > widget:first-child > #custom-launcher {
        margin-left: 5px;
      }

      /* If a module is the rightmost one, omit its right margin */
      .modules-right > widget:last-child > #clock,
      .modules-right > widget:last-child > #custom-powermenu {
        margin-right: 5px;
      }

      #custom-launcher,
      #window {
        background-color: @blue;
      }

      #mode {
        background-color: @peach;
      }

      #tray {
        background-color: transparent;
        color: @text;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: @red;
      }

      #cpu {
        background-color: @red;
      }

      #memory {
        background-color: @green;
      }

      #disk {
        background-color: @teal;
      }

      #backlight {
        background-color: @yellow;
      }

      #pulseaudio.audio,
      #pulseaudio.microphone {
        background-color: @mauve;
      }

      #pulseaudio.audio.muted,
      #pulseaudio.microphone.source-muted {
        background-color: @red;
      }

      #network {
        background-color: @sky;
      }

      #network.disconnected {
        background-color: @red;
      }

      #battery {
        background-color: @green;
      }

      #battery.warning {
        background-color: @yellow;
      }

      #battery.critical {
        background-color: @red;
        color: @text;
      }

      #clock {
        background-color: @pink;
      }

      #custom-powermenu {
        background-color: @maroon;
      }
    '';
  };
}
