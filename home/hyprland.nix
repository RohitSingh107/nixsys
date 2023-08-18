{ pkgs, ... }: {

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        xwayland = {
          enable = true;
        };


        settings = {
          "$mainMod" = "SUPER";
          monitor = [
            ",preferred,auto,1"
          ];
          exec-once = [
            "waybar"
            "pkill swaybg; swaybg -o 'eDP-1' -i ~/.config/wall/xmonad.jpg -m fill"
            "wl-paste -t text --watch clipman store"
            # "dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"
            # "nm-applet --indicator"
            # "exec xrdb -load ~/.Xresources"
            # "swaync"
            # "wl-clipboard-history -t"
            # "copyq"
            # "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK"
          ];
          input = {
            # kb_layout = "us";
            # kb_variant = "";
            # kb_model = "";
            # kb_options = "";
            # kb_rules = "";

            follow_mouse = 1;
            repeat_delay = 250;
            repeat_rate = 30;
            numlock_by_default = 1;
            # accel_profile = "flat";
            # sensitivity = 0;
            # force_no_accel = 1;
            touchpad = {
              natural_scroll = 1;
              disable_while_typing = 0;
              clickfinger_behavior = 1;
              middle_button_emulation = 1;
              tap-to-click = 1;
            };
          };


          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            "col.active_border" = "0x66cba6f7";
            "col.inactive_border" = "0x66313244";
            layout = "master";
            sensitivity = 1.0;
            # apply_sens_to_raw = 1; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
          };

          decoration = {
            rounding = 10;
            multisample_edges = true;
            # shadow_ignore_window = true;
            # drop_shadow = true;
            # shadow_range = 15;
            # shadow_render_power = 2;
            # "col.shadow" = "rgb(${primary_accent})";
            # "col.shadow" = "rgb(${background})";
            # "col.shadow_inactive" = "rgb(${background})";

            blur = {
              enabled = true;
              size = 6;
              passes = 3;
              new_optimizations = true;
              ignore_opacity = true;
              noise = 0.0117;
              contrast = 1.5;
              brightness = 1;
            };
          };

          animations = {
            enabled = true;
            # Selmer443 config
            bezier = [
              "pace,0.46, 1, 0.29, 0.99"
              "overshot,0.13,0.99,0.29,1.1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
            ];
            animation = [
              "windows,1,8,default,popin 10%"
              "windowsIn,1,6,md3_decel,slide"
              "windowsOut,1,6,md3_decel,slide"
              "windowsMove,1,6,md3_decel,slide"
              "fade,1,10,md3_decel"
              # "fade,1,3,default"
              "workspaces,1,9,md3_decel,slide"
              # "workspaces, 1, 6, default"
              "workspaces,1,4,default"
              "specialWorkspace,1,8,md3_decel,slide"
              "border,1,10,md3_decel"
              # "border,1,5,default"
            ];
          };

          misc = {
            vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
            vrr = false; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
            disable_hyprland_logo = true;
            animate_manual_resizes = true;
            suppress_portal_warnings = true;
          };

          dwindle = {
            pseudotile = true; # enable pseudotiling on dwindle
            force_split = 0;
            preserve_split = true;
            default_split_ratio = 1.0;
            no_gaps_when_only = false;
            special_scale_factor = 0.8;
            split_width_multiplier = 1.0;
            use_active_for_splits = true;
          };

          master = {
            mfact = 0.5;
            orientation = "right";
            special_scale_factor = 0.8;
            no_gaps_when_only = false;
            new_is_master = true;
            new_on_top = false;
          };

          gestures = {
            workspace_swipe = 1;
            workspace_swipe_distance = 400;
            workspace_swipe_invert = 1;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
          };

          debug = {
            damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
          };



          windowrule = [
            "tile,title:^(kitty)$"
            "float,title:^(fly_is_kitty)$"
            "opacity 1.0 override 1.0 override,^(foot)$" # Active/inactive opacity
            "opacity 1.0 override 1.0 override,^(kitty)$" # Active/inactive opacity
            "tile,^(Spotify)$"
            "tile,^(neovide)$"
            "tile,^(wps)$"
            "opacity 1.0 override 1.0 override,^(neovide)$" # Active/inactive opacity
            "float,*.exe"
            "center,*.exe"
            "float,Rofi"
            "float,copyq"
            "animation none,Rofi"
          ];



          bind = [

            # Keybindings
            "SUPER,T,togglefloating,"
            "SUPERSHIFT,S,workspaceopt,allfloat"
            "SUPERSHIFT,X,exec,pkill Hyprland"
            # bind=SUPER,E,exec,nautilus
            "SUPERSHIFT,R,exec,hyprctl reload"
            # bind=SUPERSHIFT,Space,fullscreen
            "SUPER,Space,fullscreen"
            "SUPER,R,exec,rofi -show"
            # bind=SUPER,M,exec,spotify
            "SUPER,Q,killactive,"
            "SUPERCONTROL,Q,exec,hyprctl kill"
            "SUPER,P,pseudo,"
            "SUPER,F,exec,hyprctl --batch 'keyword general:gaps_in 0 ; keyword general:gaps_out 0 ; keyword general:border_size 1'"
            "SUPER,Return,exec,kitty"
            "SUPER,D,exec,rofi -show combi"
            "SUPER,L,exec,swaylock -i ~/.config/wall/dracula-nixos.png"
            "SUPER,W,exec,firefox"
            "SUPERSHIFT,Return,exec,nautilus"
            ## Screenshots
            "SUPERSHIFT,Print,exec,slurp | grim -g - $HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot saved'"
            "SUPER,Print,exec,grim - | wl-copy && notify-send 'Screenshot copied to clipboard'"
            ",Print,exec,grim - | swappy -f - -o $HOME/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png')"



          ];







          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "SUPER,mouse:272,movewindow"
            "SUPER,mouse:273,resizewindow"
          ];


        };




        extraConfig = ''









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





# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1




          '';

      };

    };


  };

}
