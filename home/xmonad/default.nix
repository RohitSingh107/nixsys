{ pkgs, ... }: {

  xsession = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
        libFiles = {
          "MyDefaults.hs" = ./MyDefaults.hs;
        };
      };
    };


  };

}
