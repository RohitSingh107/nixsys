module XConf where


-- Data
import           XMonad

-- Hooks
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Hooks.ManageDocks            (manageDocks)

-- Utilities
import           XMonad.Util.NamedScratchpad

-- My Modules Import
import WindowManagement (myManageHook)
import MyDefaults (myModMask, myFont, myTerminal, myBrowser, myEmacs, myEditor, fileManager, ssTool)
import MyStartupHook (myStartupHook)
import XmobarConf (myWorkspaces, myXmobarConf)

myXConf xmb = def { manageHook = myManageHook <+> manageDocks,
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
                myXmobarConf xmb

        }


