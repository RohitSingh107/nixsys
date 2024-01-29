{ pkgs, ... }: {

  services.trayer = {
    enable = false;
    settings = {
      edge = "top";
      align = "right";
      widthtype = "request";
      padding = 0;
      SetDockType = true;
      alpha = 60;
      tint = "0x6790eb";
      height = 22;
    };
  };

  xsession = {
    windowManager = {
      xmonad = {
        enable = false;
        enableContribAndExtras = false;
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
