{ pkgs, ... }: {
  programs.chromium = {
    package = pkgs.brave;
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "pgjjikdiikihdfpoppgaidccahalehjh"; } # Speedtest by ookla
    ];
  };
}
