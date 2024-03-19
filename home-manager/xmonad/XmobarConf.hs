
module XmobarConf where

-- Data
import qualified Data.Map                            as M
import           Data.Maybe                          (fromJust)
import           System.IO                           (hPutStrLn)
import           XMonad

-- Layout Modiers
import qualified XMonad.StackSet                     as W

-- Hooks
import           XMonad.Hooks.StatusBar.PP



myWorkspaces = ["α ", "β ", "γ ", "δ ", "ε ", "ζ ", "η ", "θ ", "ι "]

-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

myXmobarConf xmb = xmobarPP { -- the following variables beginning with 'pp' are settings for xmobar.
                    -- ppOutput = hPutStrLn xmproc0, -- xmobar on monitor 1
                    ppOutput = hPutStrLn xmb, -- xmobar on monitor 1
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


