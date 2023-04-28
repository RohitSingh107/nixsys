import           XMonad                              (xmonad)

-- Hooks
import           XMonad.Hooks.EwmhDesktops           (ewmh)
import           XMonad.Hooks.ManageDocks            (docks)

-- Layouts
import           XMonad.Util.EZConfig                (additionalKeysP)
import           XMonad.Util.Run                     (spawnPipe)

-- My Modules Import
import           MyKeys                              (myKeys)
import           XConf                               (myXConf)

main :: IO ()
main = do
  xmobar0 <- spawnPipe "xmobar-rohit"
  xmonad $ ewmh $ docks $ myXConf xmobar0 `additionalKeysP` myKeys
