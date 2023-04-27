module MyScratchpads where

-- Data

import           XMonad

-- Utilities
import           XMonad.Util.NamedScratchpad

-- Layouts modifiers
import qualified XMonad.StackSet                     as W

-- My modules Import
import           MyDefaults                          (myTerminal)




myScratchPads :: [NamedScratchpad]
myScratchPads =
  [ NS "terminal" spawnTerm findTerm manageTerm,
    NS "mocp" spawnMocp findMocp manageMocp,
    NS "calculator" spawnCalc findCalc manageCalc,
    NS "browser" spawnBrowser findBrowser manageBrowser
  ]
  where
    spawnTerm = myTerminal ++ " -t scratchpad"
    -- spawnTerm  = myTerminal ++ " -e bash"
    findTerm = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

    spawnBrowser = "firefox"
    findBrowser = className =? "firefox"
    manageBrowser = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

    spawnMocp = myTerminal ++ " -t mocp -e mocp"
    findMocp = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w
    spawnCalc = "qalculate-gtk"
    findCalc = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
      where
        h = 0.5
        w = 0.4
        t = 0.75 - h
        l = 0.70 - w
