
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule, ScratchPad, DropDown

scratchpad = ScratchPad(
    'scratchpad', [
        DropDown('term', 'alacritty', width=0.8,
                         height=0.7, x=0.1, y=0.1, opacity=1),
        DropDown('fm', 'pcmanfm', width=0.4,
                 height=0.5, x=0.3, y=0.1, opacity=0.5),

    ]
)


