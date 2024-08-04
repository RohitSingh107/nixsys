{pkgs, ...}: {

  home.sessionVariables = {
    LIBVA_DRI3_DISABLE = 1;
  };
  programs.chromium = {
    # package = pkgs.google-chrome;
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
      {id = "pgjjikdiikihdfpoppgaidccahalehjh";} # Speedtest by ookla
    ];
  };
}
