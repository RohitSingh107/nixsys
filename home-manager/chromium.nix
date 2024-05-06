{pkgs, ...}: {
  programs.chromium = {
    # package = pkgs.google-chrome;
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoEncoder,VaapiVideoDecoder,VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-chrome-browser-cloud-management"
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "pgjjikdiikihdfpoppgaidccahalehjh";} # Speedtest by ookla
    ];
  };
}
