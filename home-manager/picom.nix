{ pkgs, ... }: {
  services.picom = {
      enable = true;
      package = pkgs.picom-next;

      backend = "glx";                              # Rendering either with glx or xrender. You'll know if you need to switch this.
      vSync = true;                                 # Should fix screen tearing

      activeOpacity = 1;                         # Node transparency
      inactiveOpacity = 0.8;
      #menuOpacity = 0.93;

      shadow = false;                               # Shadows
      shadowOpacity = 0.5;
      # shadowOffsets = [ -7 -7 ];
      fade = true;                                  # Fade
      fadeDelta = 4;
      fadeSteps = [ 0.03 0.03 ];
      opacityRules = [                              # Opacity rules if transparency is prefered
      #  "100:name = 'Picture in picture'"
      #  "100:name = 'Picture-in-Picture'"
      #  "85:class_i ?= 'rofi'"
        "80:class_i *= 'discord'"
        "80:class_i *= 'emacs'"
        "100:class_i *= 'Alacritty'"
        "70:class_i *= 'Nautilus'"
      #  "100:fullscreen"
      ];                                            # Find with $ xprop | grep "WM_CLASS"

      settings = {
        frame-opacity = 1;
        inactive-opacity-override = false;
        daemon = true;
        # use-damage = false;                         # Fixes flickering and visual bugs with borders
        # resize-damage = 1;
        # refresh-rate = 0;
        corner-radius = 0;                          # Corners
        # round-borders = 5;
        # rounded-corners-exclude = [
        #   #"window_type = 'normal'",
        #   "class_g = 'awesome'",
        #   "class_g = 'URxvt'",
        #   "class_g = 'XTerm'",
        #   "class_g = 'kitty'",
        #   "class_g = 'Alacritty'",
        #   "class_g = 'Termite'",
        #   "class_g = 'Polybar'",
        #   "class_g = 'code-oss'",
        #   "class_g = 'firefox'",
        #   "class_g = 'Thunderbird'"
        # ];
        # round-borders-rule = [
        #   "3:class_g      = 'XTerm'",
        #   "3:class_g      = 'URxvt'",
        #   "10:class_g     = 'Alacritty'",
        #   "15:class_g     = 'Signal'"
        # ];
        # shadow-exclude = [
        # "name = 'Notification'",
        # "class_g = 'Conky'",
        # "class_g ?= 'Notify-osd'",
        # "class_g = 'Cairo-clock'",
        # "class_g = 'slop'",
        # "class_g = 'Polybar'",
        # "_GTK_FRAME_EXTENTS@:c"
        # ];
        # focus-exclude = [
        #   "class_g = 'Cairo-clock'",
        #   "class_g = 'Bar'",                    # lemonbar
        #   "class_g = 'slop'"                    # maim
        # ];
        # # Animations Jonaburg
        # transition-length = 300;
        # transition-pow-x = 0.5;
        # transition-pow-y = 0.5;
        # transition-pow-w = 0.5;
        # transition-pow-h = 0.5;
        # size-transition = true;



        blur-kern = "3x3box";


        blur = {
          # requires: https://github.com/ibhagwan/picom
          method = "kawase";
          #method = "kernel";
          strength = 7;
          # deviation = 1.0;
          # kernel = "11x11gaussian";
          background = false;
          background-frame = false;
          background-fixed = false;
          kern = "3x3box";
        };

# Exclude conditions for background blur.
        blur-background-exclude = [
          #"window_type = 'dock'",
          #"window_type = 'desktop'",
          #"class_g = 'URxvt'",
          #
          # prevents picom from blurring the background
          # when taking selection screenshot with `main`
          # https://github.com/naelstrof/maim/issues/130
          "class_g = 'slop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
          
        # Extras
        experimental-backends = true;

        detect-rounded-corners = true;              # Below should fix multiple issues
        detect-client-opacity = true;
        detect-transient = true;
        detect-client-leader = false;
        mark-wmwim-focused = true;
        mark-ovredir-focues = true;
        unredir-if-possible = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        glx-copy-from-front = false;


        log-level = "warn";
        log-file = "/home/rohits/.config/picom/picom.log";
      };                                           # Extra options for picom.conf (mostly for pijulius fork)
    };
}
