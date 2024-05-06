{pkgs, ...}: {
  programs.chromium = {
    # package = pkgs.google-chrome;
    enable = true;
    commandLineArgs = [
      "--enable-features=VaapiVideoEncoder"
      "--ignore-gpu-blocklist"
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # Bitwarden
      {id = "pgjjikdiikihdfpoppgaidccahalehjh";} # Speedtest by ookla
    ];
  };
}
