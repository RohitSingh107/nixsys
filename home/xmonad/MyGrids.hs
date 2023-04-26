module MyGrids where

-- Data
import           XMonad.Actions.GridSelect
import           XMonad



import MyDefaults (myFont)

myColorizer :: Window -> Bool -> X (String, String) -- Maybe should be transferred from here
myColorizer =
  colorRangeFromClassName
    (0x28, 0x2c, 0x34) -- lowest inactive bg
    (0x28, 0x2c, 0x34) -- highest inactive bg
    (0xc7, 0x92, 0xea) -- active bg
    (0xc0, 0xa7, 0x9a) -- inactive fg
    (0x28, 0x2c, 0x34) -- active fg




-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer =
  (buildDefaultGSConfig myColorizer)
    { gs_cellheight = 40,
      gs_cellwidth = 200,
      gs_cellpadding = 6,
      gs_originFractX = 0.5,
      gs_originFractY = 0.5,
      gs_font = myFont
    }


myAppGrid =
  [ ("Termonad", "termonad"),
    ("PCManFM", "nautilus"),
    ("Emacs", "emacsclient -c -a emacs"),
    ("iPython", "alacritty -e ipython"),
    ("FreeTube", "freetube"),
    ("Kolourpaint", "kolourpaint"),
    ("Sublime Text", "subl"),
    ("Codium", "codium"),
    ("Haskell Book", "okular ~/Documents/haskell-programming-first-principles.pdf"),
    ("Geany", "geany"),
    ("LibreOffice", "libreoffice"),
    ("Stacer", "stacer"),
    ("Alacritty", "alacritty")
  ]

myWebGrid =
  [ ("Qutebrowser", "qutebrowser"),
    ("Brave", "brave"),
    ("Firefox", "firefox"),
    ("Brave Nightly", "brave-nightly"),
    ("Freetube", "freetube"),
    ("Teams", "teams"),
    ("Firefox Nightly", "firefox-nightly"),
    ("Vivaldi", "vivaldi-stable"),
    ("Kotatogram", "kotatogram-desktop"),
    ("Discord", "discord"),
    ("Google Chrome (Don't use it)", "google-chrome-unstable"),
    ("Chromium", "chromium")
    -- , ("GeaXXny", "geany")
  ]


