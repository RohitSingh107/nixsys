-- Base

-- Actions

-- Data
import           Data.Char                           (isSpace, toUpper)
import qualified Data.Map                            as M
import           Data.Maybe                          (fromJust, isJust)
import           Data.Monoid
import           Data.Tree
import           System.Directory
import           System.Exit                         (exitSuccess)
import           System.IO                           (hPutStrLn)
import           XMonad
import           XMonad.Actions.CopyWindow           (kill1)
import           XMonad.Actions.CycleWS              (Direction1D (..),
                                                      WSType (..), moveTo,
                                                      nextScreen, prevScreen,
                                                      shiftTo)
import           XMonad.Actions.GridSelect
import           XMonad.Actions.MouseResize
import           XMonad.Actions.Promote
import           XMonad.Actions.RotSlaves            (rotAllDown, rotSlavesDown)
import qualified XMonad.Actions.Search               as S
import           XMonad.Actions.WindowGo             (runOrRaise)
import           XMonad.Actions.WithAll              (killAll, sinkAll)
-- Hooks
import           XMonad.Hooks.DynamicLog             (PP (..), dynamicLogWithPP,
                                                      shorten, wrap,
                                                      xmobarColor, xmobarPP)
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks            (ToggleStruts (..),
                                                      avoidStruts, docks,
                                                      docksEventHook,
                                                      manageDocks)
import           XMonad.Hooks.ManageHelpers          (doCenterFloat,
                                                      doFullFloat, isFullscreen)
import           XMonad.Hooks.ServerMode
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Hooks.WorkspaceHistory
-- Layouts
import           XMonad.Layout.Accordion
import           XMonad.Layout.GridVariants          (Grid (Grid))
-- Layouts modifiers
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.LimitWindows          (decreaseLimit,
                                                      increaseLimit,
                                                      limitWindows)
import           XMonad.Layout.Magnifier
import qualified XMonad.Layout.MultiToggle           as MT (Toggle (..))
import           XMonad.Layout.MultiToggle           (EOT (EOT), mkToggle,
                                                      single, (??))
import           XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Renamed
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.ShowWName
import           XMonad.Layout.Simplest
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral
import           XMonad.Layout.SubLayouts
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ThreeColumns
import qualified XMonad.Layout.ToggleLayouts         as T (ToggleLayout (Toggle),
                                                           toggleLayouts)
import           XMonad.Layout.WindowArranger        (WindowArrangerMsg (..),
                                                      windowArrange)
import           XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet                     as W
-- Utilities
import           XMonad.Util.Dmenu
import           XMonad.Util.EZConfig                (additionalKeysP)
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run                     (runProcessWithInput,
                                                      safeSpawn, spawnPipe)
import           XMonad.Util.SpawnOnce

import MyDefaults (myModMask, myFont, myTerminal, myBrowser, myEmacs, myEditor, fileManager, ssTool)
import MyKeys (myKeys)

import MyScratchpads (myScratchPads)


myBorderWidth :: Dimension
myBorderWidth = 1 -- Sets border width for windows

myNormColor :: String
myNormColor = "#e39ff6" -- Border color of normal windows

myFocusColor :: String
myFocusColor = "#a1045a" -- Border color of focused windows

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

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


--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall =
  renamed [Replace "tall"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 6 $
              mySpacing 4 $
                ResizableTall 1 (3 / 100) (1 / 2) []

magnify =
  renamed [Replace "magnify"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            magnifier $
              limitWindows 12 $
                mySpacing 8 $
                  ResizableTall 1 (3 / 100) (1 / 2) []

monocle =
  renamed [Replace "monocle"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 20 Full

floats =
  renamed [Replace "floats"] $
    smartBorders $
      limitWindows 20 simplestFloat

grid =
  renamed [Replace "grid"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 12 $
              mySpacing 8 $
                mkToggle (single MIRROR) $
                  Grid (16 / 10)

spirals =
  renamed [Replace "spirals"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            mySpacing' 8 $
              spiral (6 / 7)

threeCol =
  renamed [Replace "threeCol"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 7 $
              ThreeCol 1 (3 / 100) (1 / 2)

threeRow =
  renamed [Replace "threeRow"] $
    smartBorders $
      windowNavigation $
        addTabs shrinkText myTabTheme $
          subLayout [] (smartBorders Simplest) $
            limitWindows 7
            -- Mirror takes a layout and rotates it by 90 degrees.
            -- So we are applying Mirror to the ThreeCol layout.
            $
              Mirror $
                ThreeCol 1 (3 / 100) (1 / 2)

tabs =
  renamed [Replace "tabs"]
  -- I cannot add spacing to this layout because it will
  -- add spacing between window and tabs which looks bad.
  $
    tabbed shrinkText myTabTheme

tallAccordion =
  renamed [Replace "tallAccordion"] $
    Accordion

wideAccordion =
  renamed [Replace "wideAccordion"] $
    Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme =
  def
    { fontName = myFont,
      activeColor = "#46d9ff",
      inactiveColor = "#313846",
      activeBorderColor = "#46d9ff",
      inactiveBorderColor = "#282c34",
      activeTextColor = "#282c34",
      inactiveTextColor = "#d0d0d0"
    }

-- Theme for showWName which prints current n when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme =
  def
    { swn_font = "xft:Ubuntu:bold:size=60",
      swn_fade = 1.0,
      swn_bgcolor = "#1c1f24",
      swn_color = "#ffffff"
    }

-- The layout hook
myLayoutHook =
  avoidStruts $
    mouseResize $
      windowArrange $
        T.toggleLayouts floats $
          mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
      withBorder myBorderWidth tall
        ||| Main.magnify
        ||| noBorders monocle
        ||| floats
        ||| noBorders tabs
        ||| grid
        ||| spirals
        ||| threeCol
        ||| threeRow
        ||| tallAccordion
        ||| wideAccordion

myWorkspaces = ["α ", "β ", "γ ", "δ ", "ε ", "ζ ", "η ", "θ ", "ι "]

-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook =
  composeAll
    -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
    -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
    -- I'm doing it this way because otherwise I would have to write out the full
    -- name of my workspaces and the names would be very long if using clickable workspaces.
    [ className =? "confirm" --> doFloat,
      className =? "file_progress" --> doFloat,
      className =? "dialog" --> doFloat,
      className =? "download" --> doFloat,
      className =? "error" --> doFloat,
      className =? "Gimp" --> doFloat,
      className =? "notification" --> doFloat,
      className =? "pinentry-gtk-2" --> doFloat,
      className =? "splash" --> doFloat,
      className =? "toolbar" --> doFloat,
      className =? "Nwggrid-server" --> doFloat,
      className =? "nwggrid" --> doFloat,
      className =? "Yad" --> doCenterFloat,
      className =? "Open Folder" --> doCenterFloat,
      title =? "Oracle VM VirtualBox Manager" --> doFloat,
      -- , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 3 )
      -- , className =? "brave-browser"   --> doShift ( myWorkspaces !! 1 )
      -- , className =? "qutebrowser"     --> doShift ( myWorkspaces !! 1 )
      className =? "mpv" --> doShift (myWorkspaces !! 7),
      className =? "Gimp" --> doShift (myWorkspaces !! 8),
      -- , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
      (className =? "firefox" <&&> resource =? "Dialog") --> doFloat, -- Float Firefox Dialog
      isFullscreen --> doFullFloat
    ]
    <+> namedScratchpadManageHook myScratchPads

main :: IO ()
main = do
  -- Launching three instances of xmobar on their monitors.
  xmproc0 <- spawnPipe "xmobar"
  -- xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc"
  -- xmproc2 <- spawnPipe "xmobar -x 2 $HOME/.config/xmobar/xmobarrc"
  -- the xmonad, ya know...what the WM is named after!
  xmonad $
    ewmh
      $ docks
      def
        { manageHook = myManageHook <+> manageDocks,
          --        , handleEventHook    = docks
          -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
          -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
          -- it adds a border around the window if screen does not have focus. So, my solution
          -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
          -- <+> fullscreenEventHook
          modMask = myModMask,
          terminal = myTerminal,
          startupHook = myStartupHook,
          -- , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
          layoutHook = myLayoutHook,
          workspaces = myWorkspaces,
          borderWidth = myBorderWidth,
          normalBorderColor = myNormColor,
          focusedBorderColor = myFocusColor,
          --        , logHook = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
          logHook =
            dynamicLogWithPP $
              XMonad.Hooks.StatusBar.PP.filterOutWsPP [scratchpadWorkspaceTag] $
                xmobarPP
                  { -- the following variables beginning with 'pp' are settings for xmobar.
                    ppOutput = \x -> hPutStrLn xmproc0 x, -- xmobar on monitor 1
                    --  >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
                    --  >> hPutStrLn xmproc2 x                          -- xmobar on monitor 3


--                     ppCurrent = xmobarColor "#c792ea" "" . wrap "[ " "]", -- Current workspace
--                     ppVisible = xmobarColor "#c792ea" "" . clickable, -- Visible but not current workspace
--                     ppHidden = xmobarColor "#ff5050" "" . clickable, -- Hidden workspaces
--                     ppHiddenNoWindows = xmobarColor "#98c379" "" . clickable, -- Hidden workspaces (no windows)
--                     ppTitle = xmobarColor "#b3afc2" "" . shorten 48, -- Title of active window
--                     ppSep = "<fc=#666666> <fn=1>|</fn> </fc>", -- Separator character


                    ppCurrent = xmobarColor "#ffff00" "" . wrap "[ " "]", -- Current workspace
                    ppVisible = xmobarColor "#ffffff" "" . clickable, -- Visible but not current workspace
                    ppHidden = xmobarColor "#ffff00" "" . clickable, -- Hidden workspaces
                    ppHiddenNoWindows = xmobarColor "#0000ff" "" . clickable, -- Hidden workspaces (no windows)
                    ppTitle = xmobarColor "#ffff00" "" . shorten 48, -- Title of active window
                    ppSep = "<fc=#000000> <fn=1>|</fn> </fc>", -- Separator character
                    ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!", -- Urgent workspace
                    ppExtras = [windowCount], -- # of windows current workspace
                    ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t] -- order of things in xmobar
                  }
        }
      `additionalKeysP` myKeys

