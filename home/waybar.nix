{ pkgs, ... }: {

  programs.waybar = {
    enable = true;
    package = (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }));

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
        margin = "";
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;
        gtk-layer-shell = true;



        modules-left = [ "custom/launcher" "wlr/workspaces" ];
        "custom/launcher" = {
          format = "󱗼";
          on-click = "rofi -show combi &";
          on-click-right = "rofi -show combi &";
          tooltip = false;
        };

        "wlr/workspaces" = {
          on-click = "activate";
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
            "default" = "α";


          };
        };

        modules-center = [ ];
        "hyprland/window" = {
          format = " {:.40} ";
          "separate-outputs" = false;
        };

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
        tray = {
          spacing = 10;
        };

        disk = {
          interval = 30;
          format = "{path} {percentage_free}% free";
          on-click = "filelight";
        };

        cpu = {
          format = "󰻠 {usage}%";
          on-click = "kitty -e htop";
          tooltip = false;
        };
        memory = {
          format = "󰍛 {used:0.1f}GB ({percentage}%) / {total:0.1f}GB";
          on-click = "kitty -e htop";
          tooltip = false;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃟" ];
          on-scroll-up = pkgs.writeShellScript "show_brightness.sh" ''
brightnessctl set +5%
notify-send -t 700 "Brightness: " -h int:value:"`brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'`"
            '';
          on-scroll-down = pkgs.writeShellScript "show_brightness.sh" ''
brightnessctl set 5%-
notify-send -t 700 "Brightness: " -h int:value:"`brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'`"
            '';
          on-click = "";
        };

        "pulseaudio#audio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "󰂯 {icon} {volume}%";
          format-bluetooth-muted = "󰂯 󰖁 {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋋";
            headset = "󰋋";
            phone = "";
            portable = "";
            car = "";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = pkgs.writeShellScript "show_mute.sh" ''
pactl set-sink-mute @DEFAULT_SINK@ toggle

mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print tolower($0)}')

icon="󰕾"

if [[ $mute == "mute: yes" ]]; then
    icon="󰖁"
fi

notify-send -t 700 "$icon Volume $mute"
          '';
          on-scroll-up = pkgs.writeShellScript "show_volume.sh" ''
pactl set-sink-volume @DEFAULT_SINK@ +1%
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Volume" -h int:value:"$volume"
            '';
          on-scroll-down = pkgs.writeShellScript "show_volume.sh" ''
pactl set-sink-volume @DEFAULT_SINK@ -1%
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Volume" -h int:value:"$volume"
            '';
          tooltip = false;
        };


        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 {volume}%";
          on-click = pkgs.writeShellScript "show_mute_microphone.sh" ''
pactl set-source-mute @DEFAULT_SOURCE@ toggle
mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print tolower($0)}')

icon="󰍬"

if [[ $mute == "mute: yes" ]]; then
    icon="󰍭"
fi

notify-send -t 700 "$icon Microphone $mute"
            '';
          on-scroll-up = pkgs.writeShellScript "show_volume_microphone.sh" ''
pactl set-source-volume @DEFAULT_SOURCE@ +1%
volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Microphone" -h int:value:"$volume"
            '';
          on-scroll-down = pkgs.writeShellScript "show_volume_microphone.sh" ''
pactl set-source-volume @DEFAULT_SOURCE@ -1%
volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Microphone" -h int:value:"$volume"
            '';

          max-volume = 100;
          tooltip = false;
        };




        "network#wlo1" = {
          interval = 10;
          interface = "wlo1";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          format-alt = "{icon} {essid} | 󱑽 {signalStrength}% {signaldBm} dBm {frequency} MHz";
          tooltip = false;
        };
        "network#eno1" = {
          interval = 10;
          interface = "eno1";
          format-icons = [ "󰈀" ];
          format-ethernet = "{icon}";
          format-disconnected = "{icon}";
          format-alt = "{icon} | 󰢮 {ifname} | 󰩟 {ipaddr}/{cidr}";
          tooltip = false;
        };
        bluetooth = {
          format-disabled = "󰂯 {status}";
          format-off = "";
          format-on = "󰂯";
          format-connected = "󰂯 {device_alias}";
          format-connected-battery = "󰂯 {device_alias} 󰂄 {device_battery_percentage}%";
          on-click = "";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
        clock = {
          interval = 1;
          format = "󰥔 {:%I:%M %p}";
          format-alt = "{:󰣆 %A; %B %d | 󰥔 %I:%M:%S %p}";
        };
        "custom/powermenu" = {
          format = "󰤆";
          on-click = "wlogout &";
          on-click-right = "wlogout &";
          tooltip = false;
        };

      };
    };

    style = ''


* {
  font-family: Iosevka Fixed, Material Design Icons Desktop;
  font-size: 14px;
}

@define-color rosewater #F5E0DC;
@define-color flamingo  #F2CDCD;
@define-color pink      #F5C2E7;
@define-color mauve     #CBA6F7;
@define-color red       #F38BA8;
@define-color maroon    #EBA0AC;
@define-color peach     #FAB387;
@define-color yellow    #F9E2AF;
@define-color green     #A6E3A1;
@define-color teal      #94E2D5;
@define-color sky       #89DCEB;
@define-color sapphire  #74C7EC;
@define-color blue      #89B4FA;
@define-color lavender  #B4BEFE;
@define-color text      #CDD6F4;
@define-color subtext1  #BAC2DE;
@define-color subtext0  #A6ADC8;
@define-color overlay2  #9399B2;
@define-color overlay1  #7F849C;
@define-color overlay0  #6C7086;
@define-color surface2  #585B70;
@define-color surface1  #45475A;
@define-color surface0  #313244;
@define-color base      #1E1E2E;
@define-color mantle    #181825;
@define-color crust     #11111B;

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
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 2px;
  margin-right: 2px;
  border-radius: 20px;
  transition-property: background-color;
  transition-duration: 0.3s;
}

#workspaces button:hover {
  box-shadow: inherit;
  text-shadow: inherit;
  background: @blue;
  border: @blue;
  color: @crust;
  padding: 1px 9px;
  transition-property: background-color;
  transition-duration: 1s;
}

#workspaces button.focused,
#workspaces button.active {
  background-color: @green;
  color: @crust;
  transition-property: background-color;
  transition-duration: 0.5s;
}

#workspaces button.urgent {
  background-color: @red;
  color: @crust;
  transition-property: background-color;
  transition-duration: 0.5s;
}

/* #workspaces button.hidden {} */

/* -------------------------------------------------------------------------------- */

#custom-launcher,
#window,
#tray,
#cpu,
#memory,
#disk,
#backlight,
#pulseaudio.audio,
#pulseaudio.microphone,
#network,
#bluetooth,
#battery,
#clock,
#custom-powermenu {
  color: @text;
  padding: 1px 8px;
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 2px;
  margin-right: 2px;
  border-radius: 20px;
  transition-property: background-color;
  transition-duration: 0.5s;
}

/* -------------------------------------------------------------------------------- */

#window {
  background-color: @blue;
  color: @crust;
}

#window:hover {
  background-color: @sky;
}

/* -------------------------------------------------------------------------------- */

#custom-launcher {
  background-color: @blue;
  color: @crust;
}

#custom-launcher:hover {
  background-color: @sky;
}

#custom-powermenu {
  background-color: @maroon;
  color: @crust;
}

#custom-powermenu:hover {
  background-color: @red;
}

/* -------------------------------------------------------------------------------- */

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces,
.modules-left > widget:first-child > #custom-launcher,
.modules-left > widget:first-child > #window,
.modules-left > widget:first-child > #tray,
.modules-left > widget:first-child > #cpu,
.modules-left > widget:first-child > #memory,
.modules-left > widget:first-child > #disk,
.modules-left > widget:first-child > #backlight,
.modules-left > widget:first-child > #pulseaudio.audio,
.modules-left > widget:first-child > #pulseaudio.microphone,
.modules-left > widget:first-child > #network,
.modules-left > widget:first-child > #bluetooth,
.modules-left > widget:first-child > #battery,
.modules-left > widget:first-child > #clock,
.modules-left > widget:first-child > #custom-powermenu {
  margin-left: 5px;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces,
.modules-right > widget:last-child > #custom-launcher,
.modules-right > widget:last-child > #window,
.modules-right > widget:last-child > #tray,
.modules-right > widget:last-child > #cpu,
.modules-right > widget:last-child > #memory,
.modules-right > widget:last-child > #disk,
.modules-right > widget:last-child > #backlight,
.modules-right > widget:last-child > #pulseaudio.audio,
.modules-right > widget:last-child > #pulseaudio.microphone,
.modules-right > widget:last-child > #network,
.modules-right > widget:last-child > #bluetooth,
.modules-right > widget:last-child > #battery,
.modules-right > widget:last-child > #clock,
.modules-right > widget:last-child > #custom-powermenu {
  margin-right: 5px;
}

/* -------------------------------------------------------------------------------- */

#tray {
  background-color: transparent;
}
#tray > .passive {
  -gtk-icon-effect: dim;
}
#tray > .needs-attention {
  -gtk-icon-effect: highlight;
  background-color: @red;
}

/* -------------------------------------------------------------------------------- */

#disk {
  background-color: @teal;
  /* background-color: @sapphire; */
  color: @crust;
}
#cpu {
  background-color: @red;
  /* background-color: @sapphire; */
  color: @crust;
}

#cpu:hover {
  background-color: @teal;
}

/* -------------------------------------------------------------------------------- */

#memory {
  background-color: @green;
  color: @crust;
}

#memory:hover {
  background-color: @teal;
}

/* -------------------------------------------------------------------------------- */

#backlight {
  background-color: #fff;
  color: @crust;
}

#backlight:hover {
  background-color: @rosewater;
}

/* -------------------------------------------------------------------------------- */

#pulseaudio.audio {
  background-color: @mauve;
  color: @crust;
}

#pulseaudio.audio:hover {
  background-color: @pink;
}

#pulseaudio.audio.bluetooth {
  background-color: @blue;
  color: @crust;
}

#pulseaudio.bluetooth:hover {
  background-color: @sky;
}

#pulseaudio.audio.muted {
  background-color: @red;
  color: @crust;
}

#pulseaudio.audio.muted:hover {
  background-color: @maroon;
}

#pulseaudio.microphone {
  background-color: @mauve;
  color: @crust;
}

#pulseaudio.microphone:hover {
  background-color: @pink;
}

#pulseaudio.microphone.source-muted {
  background-color: @red;
  color: @crust;
}

#pulseaudio.microphone.source-muted:hover {
  background-color: @maroon;
}

/* -------------------------------------------------------------------------------- */

#network,
#network.ethernet,
#network.wifi {
  background-color: @yellow;
  color: @crust;
}

#network:hover,
#network.ethernet:hover,
#network.wifi:hover {
  background-color: @teal;
}

#network.disabled,
#network.disconnected {
  background-color: @red;
  color: @crust;
}

#network.disabled:hover,
#network.disconnected:hover {
  background-color: @maroon;
}

/* -------------------------------------------------------------------------------- */

/* #bluetooth {} */
#bluetooth.disabled,
#bluetooth.off {
  background-color: @red;
  color: @crust;
}

#bluetooth.disabled:hover,
#bluetooth.off:hover {
  background-color: @maroon;
}

#bluetooth.on,
#bluetooth.connected {
  background-color: @sapphire;
  color: @crust;
}

#bluetooth.on:hover,
#bluetooth.connected:hover {
  background-color: @sky;
}

/* #bluetooth.discoverable {} */
/* #bluetooth.discovering {} */
/* #bluetooth.pairable {} */

/* -------------------------------------------------------------------------------- */

#battery.full {
  background-color: @green;
  color: @crust;
}

#battery.full:hover {
  background-color: @teal;
}

#battery.warning {
  background-color: @yellow;
  color: @crust;
}

#battery.warning:hover {
  background-color: @rosewater;
}

#battery.critical {
  background-color: @red;
  color: @crust;
}

#battery.critical:hover {
  background-color: @maroon;
}

#battery.charging,
#battery.plugged {
  background-color: @blue;
  color: @crust;
}

#battery.charging:hover,
#battery.plugged:hover {
  background-color: @sky;
}
#battery.discharging {
  background-color: @rosewater;
  color: @crust;
}
/* -------------------------------------------------------------------------------- */

#clock {
  background-color: @lavender;
  color: @crust;
}

#clock:hover {
  background-color: @text;
}

      '';


  };
}
