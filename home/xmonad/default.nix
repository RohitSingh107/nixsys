{ pkgs, ... }: {

  xsession = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
        libFiles = {
          "MyDefaults.hs" = ./MyDefaults.hs;
          "MyGrids.hs" = ./MyGrids.hs;
          "MyKeys.hs" = ./MyKeys.hs;
          "MyScratchpads.hs" = ./MyScratchpads.hs;

        };
      };
    };


  };

}
