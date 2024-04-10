{ pkgs, ... }: {
  programs.chromium = {
    # package = pkgs.google-chrome;
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "pgjjikdiikihdfpoppgaidccahalehjh"; } # Speedtest by ookla
    ];
  };
}
