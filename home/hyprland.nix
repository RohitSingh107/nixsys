{ pkgs, ... }: {

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        extraConfig = ''



#monitor=eDP-1,1920x1080@60,970x1080,1
#monitor=HDMI-A-1,1920x1080@60,1920x0,1
#monitor=DP-1,1920x1080@60,0x0,1
monitor=,preferred,auto,1

exec-once = pkill swaybg; swaybg -o 'eDP-1' -i "/home/rohits/.config/wall/xmonad.jpg" -m fill &

# exec-once = dunst

### Waybar Horizontal Bubbles Catppuccin Mocha
# exec-once = waybar -c ~/.config/waybar/configs/config-icons-horizontal.jsonc -s ~/.config/waybar/styles/bubbles/catppuccin-mocha/style-horizontal.css

### Waybar Vertical Bubbles Catppuccin Mocha
# exec-once = waybar -c ~/.config/waybar/configs/config-icons-vertical.jsonc -s ~/.config/waybar/styles/bubbles/catppuccin-mocha/style-vertical.css

### Waybar Horizontal Bubbles Catppuccin Mocha Black
# exec-once = waybar -c ~/.config/waybar/configs/config-icons-horizontal.jsonc -s ~/.config/waybar/styles/bubbles/catppuccin-mocha-black/style-horizontal.css

### Waybar Vertical Bubbles Catppuccin Mocha Black
# exec-once = waybar -c ~/.config/waybar/configs/config-icons-vertical.jsonc -s ~/.config/waybar/styles/bubbles/catppuccin-mocha-black/style-vertical.css

### Waybar in center and small
# exec-once= waybar -c ~/.config/waybar-small/config.jsonc -s ~/.config/waybar-small/style.css

# exec-once=exec xrdb -load ~/.Xresources
# exec-once=apply-gsettings
# exec-once=swaync
# exec-once=wl-paste -t text --watch clipman store
# exec-once=nm-applet --indicator
# # exec-once=jamesdsp -t
# exec-once=wl-clipboard-history -t
# # exec-once=wlsunset
# exec-once=copyq
# exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
# exec-once=hash dbus-update-activation-environment 2>/dev/null && \
#      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK


input {
    follow_mouse=1
    repeat_delay=250
    repeat_rate=30
	numlock_by_default=true

    touchpad {
        disable_while_typing=0
        natural_scroll=1 
        clickfinger_behavior=1
        middle_button_emulation=1
        tap-to-click=1
    }
}

general {
    border_size=2
    col.active_border=0x66cba6f7
    col.inactive_border=0x66313244
    # damage_tracking=full
    gaps_in=5
    gaps_out=10
    # main_mod=SUPER
    sensitivity=1.0
}

master {
    new_is_master=false
    new_on_top=true
}

misc {
	disable_hyprland_logo=true
	animate_manual_resizes=true
}

decoration {
    rounding=5
    blur=1
    blur_size=10
    blur_passes=3
   	blur_ignore_opacity=false
	dim_inactive=false
}

gestures {
    workspace_swipe=1
    workspace_swipe_distance=400
    workspace_swipe_invert=1
    workspace_swipe_min_speed_to_force=30
    workspace_swipe_cancel_ratio=0.5
}

animations {
    enabled=1
    animation=border,1,5,default
    animation=fade,1,3,default
    animation=workspaces,1,4,default
    animation=windows,1,8,default,popin 10%
}

$mainMod = SUPER

# Keybindings
bind=SUPER,T,togglefloating,
bind=SUPERSHIFT,S,workspaceopt,allfloat
bind=SUPERSHIFT,X,exec,pkill Hyprland
# bind=SUPER,E,exec,nautilus
bind=SUPERSHIFT,R,exec,hyprctl reload
# bind=SUPERSHIFT,Space,fullscreen
bind=SUPER,Space,fullscreen
bind=SUPER,R,exec,rofi -show
# bind=SUPER,M,exec,spotify
bind=SUPER,Q,killactive,
bind=SUPERCONTROL,Q,exec,hyprctl kill
bind=SUPER,P,pseudo,
bind=SUPER,F,exec,hyprctl --batch "keyword general:gaps_in 0 ; keyword general:gaps_out 0 ; keyword general:border_size 1"
bind=SUPER,Return,exec,kitty
bind=SUPER,D,exec,rofi -show combi
bind=SUPER,L,exec,swaylock -i /usr/share/wallpapers/garuda/Dracula\ Dragon\ Remix.png
bind=SUPER,W,exec,firefox-nightly
bind=SUPERSHIFT,Return,exec,pcmanfm
## Screenshots
bind=SUPERSHIFT,Print,exec,slurp | grim -g - $HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot saved'
bind=SUPER,Print,exec,grim - | wl-copy && notify-send 'Screenshot copied to clipboard'
bind=,Print,exec,grim - | swappy -f - -o $HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png')

bind=SUPERALT,space,exec,playerctl play-pause
bind=SUPERALT,bracketright,exec,playerctl next
bind=SUPERALT,bracketleft,exec,playerctl previous
bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%
bind=,XF86AudioPlay,exec,playerctl play-pause
bind=,XF86AudioNext,exec,playerctl next
bind=,XF86AudioPrev,exec,playerctl previous

bind=SUPER,1,workspace,1
bind=SUPER,2,workspace,2
bind=SUPER,3,workspace,3
bind=SUPER,4,workspace,4
bind=SUPER,5,workspace,5
bind=SUPER,6,workspace,6
bind=SUPER,7,workspace,7
bind=SUPER,8,workspace,8
bind=SUPER,9,workspace,9
bind=SUPER,0,workspace,10

bind=SUPERCTRL,left,resizeactive,-20 0
bind=SUPERCTRL,right,resizeactive,20 0
bind=SUPERCTRL,up,resizeactive,0 -20
bind=SUPERCTRL,down,resizeactive,0 20

bind=SUPERSHIFT,1,movetoworkspacesilent,1
bind=SUPERSHIFT,2,movetoworkspacesilent,2
bind=SUPERSHIFT,3,movetoworkspacesilent,3
bind=SUPERSHIFT,4,movetoworkspacesilent,4
bind=SUPERSHIFT,5,movetoworkspacesilent,5
bind=SUPERSHIFT,6,movetoworkspacesilent,6
bind=SUPERSHIFT,7,movetoworkspacesilent,7
bind=SUPERSHIFT,8,movetoworkspacesilent,8
bind=SUPERSHIFT,9,movetoworkspacesilent,9
bind=SUPERSHIFT,0,movetoworkspacesilent,10

# Scratchpads
bind=SUPERCONTROL,s,movetoworkspacesilent,special
bind=SUPER,S,togglespecialworkspace
bind=CONTROL,Return,togglespecialworkspace

bind=SUPER,left,movefocus,l
bind=SUPER,right,movefocus,r
bind=SUPER,up,movefocus,u
bind=SUPER,down,movefocus,d
bind=SUPER,h,movefocus,l
bind=SUPER,l,movefocus,r
bind=SUPER,k,movefocus,u
bind=SUPER,j,movefocus,d
bind=SUPERSHIFT,left,movewindow,l
bind=SUPERSHIFT,right,movewindow,r
bind=SUPERSHIFT,up,movewindow,u
bind=SUPERSHIFT,down,movewindow,d
bind=SUPERSHIFT,h,movewindow,l
bind=SUPERSHIFT,l,movewindow,r
bind=SUPERSHIFT,k,movewindow,u
bind=SUPERSHIFT,j,movewindow,d
# bind=SUPERCONTROL,left,workspace,-1
# bind=SUPERCONTROL,right,workspace,+1
# bind=SUPERCONTROL,up,focusmonitor,l
# bind=SUPERCONTROL,down,focusmonitor,r
bind=SUPER,tab,changegroupactive, f
bind=SUPERSHIFT,ISO_Left_Tab,changegroupactive, b
bind=SUPERALT,tab,togglegroup
# bind=SUPERALT,left,splitratio,-0.1
# bind=SUPERALT,right,splitratio,+0.1
# bind=SUPERALT,h,splitratio,-0.1
# bind=SUPERALT,l,splitratio,+0.1


bind=SUPERCONTROL,h,workspace,-1
bind=SUPERCONTROL,l,workspace,+1
bind=SUPERCONTROL,k,focusmonitor,l
bind=SUPERCONTROL,j,focusmonitor,r


# Window rules
# windowrule=workspace 1 silent,Vscodium
# windowrule=workspace 2 silent,FireDragon
windowrule=float,*.exe
windowrule=center,*.exe
windowrule=float,Rofi
windowrule=float,copyq
windowrule=animation none,Rofi


# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow



          '';
        # settings = {
        #   "$mod" = "SUPER";
        #   bind = [
        #     "$mod, Return, exec, kitty"
        #
        #   ];
        # };
      };

    };


  };

}
