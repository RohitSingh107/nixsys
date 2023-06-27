from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule, ScratchPad, DropDown
from libqtile.command import lazy

from defaults import mod, mod1, mod2, home, myTerm
from groups import groups


def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


# ## Need work here
# @lazy.function
# def increase_gaps(qtile):
#     qtile.current_layout.margin += 10
#     qtile.current_group.layout_all()
#
#
# @lazy.function
# def decrease_gaps(qtile):
#     if qtile.current_layout.margin > 0:
#         qtile.current_layout.margin -= 10
#         qtile.current_group.layout_all()

@lazy.layout.function
def change_layout_gap(layout, adjustment):
    if adjustment < 0 and layout.margin <= 0:
        return
    layout.margin += adjustment
    layout.cmd_reset()


keys = [



    # SUPER + FUNCTION KEYS

    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "t", lazy.spawn('xterm')),
    Key([mod], "v", lazy.spawn('pavucontrol')),
    Key([mod], "d", lazy.spawn(
        "dmenu_run -i -nb '#191919' -nf '#ff1493' -sb '#ff1493' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=15'")),
    Key([mod], "Escape", lazy.spawn('xkill')),
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "KP_Enter", lazy.spawn('alacritty')),
    Key([mod], "x", lazy.shutdown()),

    # SUPER + SHIFT KEYS

    Key([mod, "shift"], "Return", lazy.spawn('pcmanfm')),
    # Key([mod], "d", lazy.spawn('nwggrid -p -o 0.4')),
    #    Key([mod, "shift"], "d", lazy.spawn(home + '/.config/qtile/scripts/dmenu.sh')),
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "shift"], "x", lazy.shutdown()),

    # CONTROL + ALT KEYS

    Key(["mod1", "control"], "p", lazy.spawn(
        home + '/.config/qtile/scripts/picom-toggle.sh')),
    Key(["mod1", "control"], "t", lazy.spawn('xterm')),
    Key(["mod1", "control"], "u", lazy.spawn('pavucontrol')),

    # ALT + ... KEYS


    Key(["mod1"], "p", lazy.spawn('pamac-manager')),
    Key(["mod1"], "f", lazy.spawn('firedragon')),
    Key(["mod1"], "m", lazy.spawn('pcmanfm')),
    Key(["mod1"], "w", lazy.spawn('garuda-welcome')),


    # CONTROL + SHIFT KEYS

    Key([mod2, "shift"], "Escape", lazy.spawn('lxtask')),


    # SCREENSHOTS

    Key([], "Print", lazy.spawn('flameshot full -p ' + home + '/Pictures')),
    Key([mod2], "Print", lazy.spawn('flameshot full -p ' + home + '/Pictures')),
    #    Key([mod2, "shift"], "Print", lazy.spawn('gnome-screenshot -i')),

    # MULTIMEDIA KEYS

    # INCREASE/DECREASE BRIGHTNESS
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%- ")),

    # INCREASE/DECREASE/MUTE VOLUME
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),

    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),

    #    Key([], "XF86AudioPlay", lazy.spawn("mpc toggle")),
    #    Key([], "XF86AudioNext", lazy.spawn("mpc next")),
    #    Key([], "XF86AudioPrev", lazy.spawn("mpc prev")),
    #    Key([], "XF86AudioStop", lazy.spawn("mpc stop")),

    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),


    # RESIZE UP, DOWN, LEFT, RIGHT

    # Key([mod], "h",
    #     # lazy.layout.shrink(),
    #     lazy.layout.increase_margin(),
    #     desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
    #     ),
    # Key([mod], "l",
    #     # lazy.layout.grow(),
    #     lazy.layout.decrease_margin(),
    #     desc='Expand window (MonadTall), increase number in master pane (Tile)'
    #     ),


    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),


    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),

    # FLIP LAYOUT FOR BSP
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),

    # MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

    # Treetab controls
    Key([mod, "control"], "k",
        lazy.layout.section_up(),
        desc='Move up a section in treetab'
        ),
    Key([mod, "control"], "j",
        lazy.layout.section_down(),
        desc='Move down a section in treetab'
        ),



    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),



    # MOVE WINDOW TO NEXT SCREEN
    Key([mod, "shift"], "Right", lazy.function(
        window_to_next_screen, switch_screen=True)),
    Key([mod, "shift"], "Left", lazy.function(
        window_to_previous_screen, switch_screen=True)),



    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),



    # ScratchPad
    Key(["control"], "Return", lazy.group['scratchpad'].dropdown_toggle('term')),
    # Key(["control"], "s", lazy.group['scratchpad'].dropdown_toggle('fm')),

    # Increase/Decrease Gaps
    Key([mod], 'g', change_layout_gap(adjustment=-1), desc='decrease gap by 1'),
    Key([mod, 'shift'], 'g', change_layout_gap(
        adjustment=1), desc='increase gap by 1')
]


for i in groups:
    keys.extend([

        # CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
        Key(["mod1"], "Tab", lazy.screen.next_group()),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        #Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(
            i.name), lazy.group[i.name].toscreen()),
    ])


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]
