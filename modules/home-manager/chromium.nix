{pkgs, ...}: {

  home.sessionVariables = {
    LIBVA_DRI3_DISABLE = 1;
  };
  programs.chromium = {
    package = pkgs.brave;
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-chrome-browser-cloud-management"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "bfbameneiokkgbdmiekhjnmfkcnldhhm";} # Web development tools
    ];
  };
}
