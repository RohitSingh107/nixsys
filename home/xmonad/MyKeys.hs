module MyKeys where


-- Data
import           Data.Maybe                          (fromJust, isJust)
import           XMonad
import System.Exit (exitSuccess)
import           XMonad.Actions.CopyWindow           (kill1)
import           XMonad.Actions.GridSelect
import           XMonad.Actions.Promote
import           XMonad.Actions.RotSlaves            (rotAllDown, rotSlavesDown)
import           XMonad.Actions.WindowGo             (runOrRaise)
import           XMonad.Actions.CycleWS              (Direction1D (..),
                                                      WSType (..), moveTo,
                                                      nextScreen, prevScreen,
                                                      shiftTo)

-- Layouts modifiers
import qualified XMonad.StackSet                     as W
import qualified XMonad.Layout.ToggleLayouts         as T (ToggleLayout (Toggle), toggleLayouts)
import qualified XMonad.Layout.MultiToggle           as MT (Toggle (..))
import           XMonad.Layout.Tabbed
import           XMonad.Actions.WithAll              (killAll, sinkAll)
import           XMonad.Layout.Spacing
import           XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import           XMonad.Layout.LimitWindows          (decreaseLimit,
                                                      increaseLimit,
                                                      limitWindows)

import           XMonad.Layout.ResizableTile
-- Utilities
import           XMonad.Util.NamedScratchpad
import           XMonad.Layout.SubLayouts

-- Hooks
import           XMonad.Hooks.ManageDocks            (ToggleStruts (..),
                                                      avoidStruts, docks,
                                                      docksEventHook,
                                                      manageDocks)

-- My modules Import
import MyDefaults (myModMask, myFont, myTerminal, myBrowser, myEmacs, myEditor, fileManager, ssTool)
import MyScratchpads (myScratchPads)
import MyGrids (myAppGrid, myWebGrid, mygridConfig, myColorizer) -- Mybe shit mycolorizer








spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf =
      def
        { gs_cellheight = 40,
          gs_cellwidth = 200,
          gs_cellpadding = 6,
          gs_originFractX = 0.5,
          gs_originFractY = 0.5,
          gs_font = myFont
        }

myKeys :: [(String, X ())]
myKeys =
  -- SUPER + SHIFT KEYS
  [ ("M-S-r", spawn "xmonad --restart"), -- Recompiles xmonad
    ("M-S-x", io exitSuccess), -- Quits xmonad
    -- ("M-S-/", spawn "~/.config/xmonad/xmonad_keys.sh"),
    ("M-S-<Return>", spawn "nautilus"), -- File Manager
    -- , ("M-S-<Return>", spawn "dmenu_run -i -p \"Run: \"") -- Dmenu
    ("M-S-d", spawn "nwggrid -p -o 0.4"),
    ("M-S-q", kill1), -- Kill the currently focused client
    ("M-S-a", killAll), -- Kill all windows on current workspace

    -- SUPER + ... KEYS
    ("M-<Return>", spawn myTerminal),
    ("M-q", kill1), -- Kill the currently focused client
    ("M-b", spawn myBrowser),
    ("M-d", spawn "dmenu_run -i -nb '#191919' -nf '#ff1493' -sb '#ff1493' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=15' -p \"Run: \""), -- Dmenu


    -- SUPER + s KEYSTROKES
    ("C-<Return>", namedScratchpadAction myScratchPads "terminal"),
    ("C-w", namedScratchpadAction myScratchPads "browser"),
    ("M-s m", namedScratchpadAction myScratchPads "mocp"),
    ("M-s c", namedScratchpadAction myScratchPads "calculator"),
    -- SUPER + ALT KEYS
    ("M-M1-h", spawn (myTerminal ++ " -e htop")),
    -- CONTROL + ... KEYS
    ("C-g g", spawnSelected' myAppGrid), -- grid select favorite apps
    ("C-g w", spawnSelected' myWebGrid), -- grid select favorite apps
    ("C-g t", goToSelected $ mygridConfig myColorizer), -- goto selected window
    ("C-g b", bringSelected $ mygridConfig myColorizer), -- bring selected window

    -- CONTROL + ALT KEYS
    ("C-M1-p", spawn ("$HOME/.config/xmonad/picom-toggle.sh")),
    ("C-M1-w", spawn ("feh --randomize --bg-fill /home/rohits/Pictures/wallpapers/*.jpg")),
    -- CONTROL + e KEYSTROKES
    -- , ("C-e e", spawn myEmacs)                 -- start emacs
    ("C-e e", spawn (myEmacs ++ ("--eval '(dashboard-refresh-buffer)'"))), -- emacs dashboard
    ("C-e b", spawn (myEmacs ++ ("--eval '(ibuffer)'"))), -- list buffers
    ("C-e d", spawn (myEmacs ++ ("--eval '(dired nil)'"))), -- dired
    ("C-e i", spawn (myEmacs ++ ("--eval '(erc)'"))), -- erc irc client
    ("C-e s", spawn (myEmacs ++ ("--eval '(eshell)'"))), -- eshell
    ("C-e t", spawn (myEmacs ++ ("--eval '(mastodon)'"))), -- mastodon.el
    ("C-e v", spawn (myEmacs ++ ("--eval '(vterm nil)'"))), -- vterm if on GNU Emacs
    ("C-e w", spawn (myEmacs ++ ("--eval '(eww \"distrotube.com\")'"))), -- eww browser if on GNU Emacs

    -- Super + p KEYSTROKES (dmenu)
    ("M-p a", spawn "dm-sounds"), -- choose an ambient background
    ("M-p b", spawn "dm-setbg"), -- set a background
    ("M-p c", spawn "dm-colpick"), -- pick color from our scheme
    ("M-p e", spawn "dm-confedit"), -- edit config files
    ("M-p i", spawn "dm-maim"), -- screenshots (images)
    ("M-p k", spawn "dm-kill"), -- kill processes
    ("M-p m", spawn "dm-man"), -- manpages
    ("M-p o", spawn "dm-bookman"), -- qutebrowser bookmarks/history
    ("M-p p", spawn "passmenu"), -- passmenu
    ("M-p q", spawn "dm-logout"), -- logout menu
    ("M-p r", spawn "dm-reddit"), -- reddio (a reddit viewer)
    ("M-p s", spawn "dm-websearch"), -- search various search engines

    -- SUPER + FUNCTION KEYS
    ("M-<F1>", spawn "sxiv -r -q -t -o /usr/share/backgrounds/dtos-backgrounds/*"),
    ("M-<F2>", spawn "find /usr/share/backgrounds/dtos-backgrounds// -type f | shuf -n 1 | xargs xwallpaper --stretch"),
    -- SCREENSHOT
    ("C-<Print>", spawn "flameshot"),
    ("<Print>", spawn "flameshot full -p $HOME/Pictures"),
    -- Windows Movement and Focus Shift

    -- Move Window to Workspace
    ("M-.", nextScreen), -- Switch focus to next monitor
    ("M-,", prevScreen), -- Switch focus to prev monitor
    ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP), -- Shifts focused window to next ws
    ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP), -- Shifts focused window to prev ws

    -- Shift Focus
    ("M-m", windows W.focusMaster), -- Move focus to the master window
    ("M-j", windows W.focusDown), -- Move focus to the next window
    ("M-<Down>", windows W.focusDown), -- Move focus to the next window
    ("M-k", windows W.focusUp), -- Move focus to the prev window
    ("M-<Up>", windows W.focusUp), -- Move focus to the prev window

    -- Swapping and Movement
    ("M-S-m", windows W.swapMaster), -- Swap the focused window and the master window
    ("M-S-j", windows W.swapDown), -- Swap focused window with next window
    ("M-S-k", windows W.swapUp), -- Swap focused window with prev window
    ("M-<Backspace>", promote), -- Moves focused window to master, others maintain order
    ("M-S-<Tab>", rotSlavesDown), -- Rotate all windows except master and keep focus in place
    ("M-C-<Tab>", rotAllDown), -- Rotate all the windows in the current stack

    -- Increasing/Decreasing Windows Spacing (Gaps) and Size

    -- Increase/decrease spacing (gaps)
    ("C-M1-j", decWindowSpacing 4), -- Decrease window spacing
    ("C-M1-k", incWindowSpacing 4), -- Increase window spacing
    ("C-M1-h", decScreenSpacing 4), -- Decrease screen spacing
    ("C-M1-l", incScreenSpacing 4), -- Increase screen spacing

    -- Toggle Float/Tiling
    ("M-f", sendMessage (T.Toggle "floats")), -- Toggles my 'floats' layout
    ("M-t", withFocused $ windows . W.sink), -- Push floating window back to tile
    ("M-S-t", sinkAll), -- Push ALL floating windows to tile

    -- Switch Layouts and Toggle FULLSCREEN
    ("M-<Tab>", sendMessage NextLayout), -- Switch to next layout
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts), -- Toggles noborder/full

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
    ("M-M1-k", sendMessage (IncMasterN 1)), -- Increase # of clients master pane
    ("M-M1-j", sendMessage (IncMasterN (-1))), -- Decrease # of clients master pane
    ("M-C-<Up>", increaseLimit), -- Increase # of windows
    ("M-C-<Down>", decreaseLimit), -- Decrease # of windows

    -- KB_GROUP Window resizing
    ("M-h", sendMessage Shrink), -- Shrink horiz window width
    ("M-l", sendMessage Expand), -- Expand horiz window width
    ("M-S-<Down>", sendMessage MirrorShrink), -- Shrink vert window width
    ("M-S-<Up>", sendMessage MirrorExpand), -- Expand vert window width

    -- KB_GROUP Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
    ("M-C-h", sendMessage $ pullGroup L),
    ("M-C-l", sendMessage $ pullGroup R),
    ("M-C-k", sendMessage $ pullGroup U),
    ("M-C-j", sendMessage $ pullGroup D),
    ("M-C-m", withFocused (sendMessage . MergeAll)),
    -- , ("M-C-u", withFocused (sendMessage . UnMerge))
    ("M-C-/", withFocused (sendMessage . UnMergeAll)),
    ("M-C-.", onGroup W.focusUp'), -- Switch focus to next tab
    ("M-C-,", onGroup W.focusDown'), -- Switch focus to prev tab

    -- Brightness Control

    ("<XF86MonBrightnessUp>", spawn "brightnessctl s +5%"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl s 5%-"),
    -- KB_GROUP Multimedia Keys
    ("<XF86AudioPlay>", spawn "mocp --play"),
    ("<XF86AudioPrev>", spawn "mocp --previous"),
    ("<XF86AudioNext>", spawn "mocp --next"),
    ("<XF86AudioMute>", spawn "amixer set Master toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute"),
    ("<XF86Search>", spawn "dm-websearch"),
    ("<XF86Mail>", runOrRaise "thunderbird" (resource =? "thunderbird")),
    ("<XF86Calculator>", runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk")),
    ("<XF86Eject>", spawn "toggleeject")
  ]
  where
    -- The following lines are needed for named scratchpads.
    nonNSP = WSIs (return (\ws -> W.tag ws /= "NSP"))
    nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

-- END_KEYS


