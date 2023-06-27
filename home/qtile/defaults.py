
import os
from libqtile import qtile

if qtile.core.name == "x11":
    myTerm = "alacritty"
elif qtile.core.name == "wayland":
    myTerm = "foot"

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
# myTerm = "alacritty" # My terminal of choice
colorscheme = "default"


