module MyDefaults where

-- Data
import           XMonad (KeyMask, mod4Mask, Dimension)

myModMask :: KeyMask
myModMask = mod4Mask -- Sets modkey to super/windows key

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myTerminal :: String
myTerminal = "kitty" -- Sets default terminal

myBrowser :: String
myBrowser = "firefox" -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' " -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = "nvim " -- Sets emacs as editor

ssTool :: String
ssTool = "flameshot"

fileManager :: String
fileManager = "nautilus"


myBorderWidth :: Dimension
myBorderWidth = 3 -- Sets border width for windows

myUnFocusColor :: String
myUnFocusColor = "#e39ff6" -- Border color of normal windows

myFocusColor :: String
myFocusColor = "#a1045a" -- Border color of focused windows


