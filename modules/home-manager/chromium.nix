{pkgs, ...}: {
  home.sessionVariables = {
    LIBVA_DRI3_DISABLE = 1;
  };
  programs.chromium = {
    package = pkgs.google-chrome;
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-chrome-browser-cloud-management"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];
    # home-manager now asserts on this: google-chrome only picks up external
    # extensions from system-managed dirs, so declaring them here never worked.
    # Install from the Web Store / Chrome sync instead.
    #   cjpalhdlnbpafiamejdnhcphjbkeiagm  ublock origin
    #   nngceckbapebfimnlniiiahkandclblb  Bitwarden
    #   bfbameneiokkgbdmiekhjnmfkcnldhhm  Web development tools
  };
}
