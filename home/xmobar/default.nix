{ pkgs, ... }: {

  home.file = {
    ".config/xmobar/trayer-padding-icon.sh" = {

      source = ./trayer-padding-icon.sh;

      executable = true;
    };

  };


  programs.xmobar = {
    enable = true;
    extraConfig = ''
      -- Xmobar (http://projects.haskell.org/xmobar/)
      -- This is the default xmobar configuration for DTOS.
      -- This config is packaged in the DTOS repo as dtos-xmobar
      -- Dependencies: otf-font-awesome ttf-mononoki ttf-ubuntu-font-family trayer
      -- Also depends on scripts from dtos-local-bin from the dtos-core-repo.

      Config { font            = "xft:Ubuntu:weight=bold:pixelsize=11:antialias=true:hinting=true"
             , additionalFonts = [ "xft:Mononoki:pixelsize=11:antialias=true:hinting=true"
                                 , "xft:Font Awesome 5 Free Solid:pixelsize=12"
                                 , "xft:Font Awesome 5 Brands:pixelsize=12"
                                 , "xft:Ubuntu:weight=bold:pixelsize=14:antialias=true:hinting=true"
                                 ]
             -- , bgColor      = "#000000"
             , bgColor      = "#282c34"
             , fgColor      = "#ff6c6b"
             , alpha        = 90 -- (0 - 255)
             -- Position TopSize and BottomSize take 3 arguments:
             --   an alignment parameter (L/R/C) for Left, Right or Center.
             --   an integer for the percentage width, so 100 would be 100%.
             --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
             --   NOTE: The height should be the same as the trayer (system tray) height.
             , position       = TopSize L 100 24
             , lowerOnStart = True
             , hideOnStart  = False
             , allDesktops  = True
             , persistent   = True
             , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
             , commands = [
                              -- Echos a "Cloud" icon in front of the kernel output.
                            Run Com "echo" ["<fn=2>\xf0c2</fn>"] "penguin" 3600
                              -- Get kernel version (script found in .local/bin)
                          , Run Com ".local/bin/kernel" [] "kernel" 36000
                              -- Cpu usage in percent
                          , Run Cpu ["-t", "<fn=2>\xf2db</fn>  cpu: (<fc=#ff6c6b><total>%</fc>)","-H","50","--high","red"] 20
                              -- Ram used number and percent
                          , Run Memory ["-t", "<fn=2>\xf538</fn>  mem: <fc=#daa520><used></fc>M (<fc=#ff6c6b><usedratio>%</fc>)"] 20
                              -- Disk space free
                          , Run DiskU [("/", "<fn=2>\xf0c7</fn>  hdd: <fc=#00ff00><free></fc> free")] [] 60
                              -- Echos an "up arrow" icon in front of the uptime output.
                          , Run Com "echo" ["<fn=2>\xf0e7</fn>"] "uparrow" 3600
                              -- Uptime
                          , Run Uptime ["-t", "uptime: <days>d <hours>h"] 360
                              -- Echos a "bell" icon in front of the pacman updates.
                          , Run Com "echo" ["<fn=2>\xf0f3</fn>"] "bell" 3600
                              -- Check for pacman updates (script found in .local/bin)
                          , Run Com ".local/bin/pacupdate" [] "pacupdate" 36000
                              -- Time and date
                          , Run Date "<fn=2>\xf017</fn>  %b %d %Y - (<fc=#00ff00>%H:%M</fc>) " "date" 50
                              -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
                          , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                              -- Prints out the left side items such as workspaces, layout, etc.
                          , Run UnsafeStdinReader


                          , Run WeatherX "VIDP" [ ("clear", "🌣")
                                                , ("sunny", "🌣")
                                                , ("mostly clear", "🌤")
                                                , ("mostly sunny", "🌤")
                                                , ("partly sunny", "⛅")
                                                , ("fair", "🌑")
                                                , ("cloudy","☁")
                                                , ("overcast","☁")
                                                , ("partly cloudy", "⛅")
                                                , ("mostly cloudy", "🌧")
                                                , ("considerable cloudiness", "⛈")]
                                                ["-t", "<fn=1><skyConditionS></fn> <tempC>° <rh>%"
                                                , "-L","10", "-H", "25", "--normal", "black"
                                                , "--high", "lightgoldenrod4", "--low", "darkseagreen4"]
                                                18000


                    
      		        -- Weather
      		            , Run Com "/home/rohit/.config/xmobar/scripts/weather.sh" [] "weather" 20

      		            -- Battery 
                          , Run Battery        [ "--template" , "Batt: <acstatus>"
                                               , "--Low"      , "10"        -- units: %
                                               , "--High"     , "80"        -- units: %
                                               , "--low"      , "darkred"
                                               , "--normal"   , "darkorange"
                                               , "--high"     , "darkgreen"

                                               , "--" -- battery specific options
                                                         -- discharging status
                                                         , "-o"	, "<left>% (<timeleft>)"
                                                         -- AC "on" status
                                                         , "-O"	, "<left>% <fc=#dAA520>Charging</fc>"
                                                         -- charged status
                                                         , "-i"	, "<fc=#006000>Charged</fc>"
                                   ] 50

      		            
                          ]
             , sepChar = "%"
             , alignSep = "}{"
             , template = " <action=`nwggrid -p -o 0.4`><fc=#666666><icon=haskell_20.xpm/></fc></action>   <fc=#666666>|</fc> <fn=4>%UnsafeStdinReader%</fn> }{ <box type=Bottom width=2 mb=2 color=#ecbe7b><fc=#ecbe7b><action=`alacritty -e htop`>%cpu%</action></fc></box> <box type=Bottom width=2 mb=2 color=#cc8899><fc=#cc8899><action=`alacritty -e htop`>%memory%</action></fc></box> <box type=Bottom width=2 mb=2 color=#a9a1e1><fc=#a9a1e1><action=`gparted`>%disku%</action></fc></box> <box type=Bottom width=2 mb=2 color=#98be65><fc=#98be65>%uparrow%  <action=`stacer`>%battery%</action></fc></box> <box type=Bottom width=2 mb=2 color=#46d9ff><fc=#46d9ff><action=`gsimplecal`>%date%</action></fc></box> %trayerpad% "
             }


    '';

  };


}
