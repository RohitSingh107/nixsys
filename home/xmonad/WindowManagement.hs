module WindowManagement where


-- Data
import           XMonad
import           Data.Monoid

-- Hooks
import           XMonad.Hooks.ManageHelpers          (doCenterFloat, doFullFloat, isFullscreen)

-- Utilities
import           XMonad.Util.NamedScratchpad

-- My Module Import
import MyScratchpads (myScratchPads)
import XmobarConf (myWorkspaces)

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
