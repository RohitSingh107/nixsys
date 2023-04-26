module MyStartupHook where



-- Data
import           XMonad

-- Hooks

import           XMonad.Hooks.SetWMName

-- Utilities
import           XMonad.Util.SpawnOnce

myStartupHook :: X ()
myStartupHook = do
  -- spawnOnce "lxsession &"
  -- spawnOnce "picom &"
  -- spawnOnce "nm-applet &"
  -- spawnOnce "volumeicon &"
  -- spawnOnce "conky -c $HOME/.config/conky/doomone-xmonad.conkyrc"
  spawnOnce "trayer --edge top --align right --widthtype request --padding 0 --SetDockType true --SetPartialStrut true --expand false --monitor 0 --transparent true --alpha 60 --tint 0x6790eb  --height 22 &"
  -- spawnOnce "trayer --edge top --align right --widthtype request --padding 0 --SetDockType true --SetPartialStrut false --expand true --monitor 1 --transparent true --alpha 180 --tint 0x282c34  --height 22 &"
  spawnOnce "flameshot &"
  -- spawnOnce "emacs --daemon &" -- emacs daemon for the emacsclient
  -- uncomment to restore last saved wallpaper
  -- spawnOnce "feh --randomize --bg-fill /home/rohit/Pictures/wallpapers/0051.jpg"
  -- spawnOnce "feh --randomize --bg-fill /home/rohit/Pictures/wallpapers/0108.jpg"
  -- spawnOnce "feh --randomize --bg-fill /home/rohit/Pictures/wallpapers/0253.jpg"
  -- spawnOnce "feh --randomize --bg-fill /home/rohits/Pictures/wallpapers/0258.jpg"
  -- spawnOnce "feh --randomize --bg-fill /home/rohit/Pictures/wallpapers/0294.jpg"
  -- spawnOnce "feh --randomize --bg-fill /home/rohit/Pictures/wall.jpg"
  --uncomment to set a random wallpaper on login
  -- spawnOnce "find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch"

  -- spawnOnce "~/.fehbg &"  -- set last saved feh wallpaper
  -- spawnOnce "feh --randomize --bg-fill ~/.config/wall" -- feh set random wallpaper
  spawnOnce "feh --bg-fill ~/.config/wall/xmonad.jpg"
  -- spawnOnce "nitrogen --restore &"   -- if you prefer nitrogen to feh
  setWMName "LG3D"


