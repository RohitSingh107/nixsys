module MyDefaults where

-- Data
import           XMonad

myModMask :: KeyMask
myModMask = mod4Mask -- Sets modkey to super/windows key

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "alacritty" -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser" -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' " -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = "emacsclient -c -a 'emacs' " -- Sets emacs as editor

ssTool :: String
ssTool = "flameshot"

fileManager :: String
fileManager = "nautilus"
