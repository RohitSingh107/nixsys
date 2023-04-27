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
          "MyStartupHook.hs" = ./MyStartupHook.hs;
          "MyWindowsLayout.hs" = ./MyWindowsLayout.hs;
          "WindowManagement.hs" = ./WindowManagement.hs;
          "XConf.hs" = ./XConf.hs;
          "XmobarConf.hs" = ./XmobarConf.hs;
        };
      };
    };


  };

}
