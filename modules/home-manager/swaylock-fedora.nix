{...}: {
  # Lock screen for the Fedora sway session. swaylock.nix is the variant for
  # the NixOS host: it installs swaylock-effects for blur and a clock, neither
  # of which plain swaylock (what Fedora ships) supports.
  programs.swaylock = {
    enable = true;

    # dnf's swaylock, and importantly its PAM configuration in
    # /etc/pam.d/swaylock -- a Nix swaylock would need its own to unlock at all.
    package = null;

    settings = {
      # Same wallpaper sway paints on the desktop.
      image = "${../../wallpapers/dracula-linux.png}";
      scaling = "fill";

      font = "Fantasque Sans Mono";
      font-size = 24;

      indicator-radius = 110;
      indicator-thickness = 10;
      indicator-caps-lock = true;
      # Otherwise the ring only shows up once you start typing.
      indicator-idle-visible = true;
      show-failed-attempts = true;
      ignore-empty-password = true;

      # Catppuccin Mocha, matching waybar, mako and wofi. The ring carries the
      # state: mauve at rest, blue verifying, green cleared, red wrong, peach
      # for caps lock, with each keypress flashing pink.
      inside-color = "#1E1E2EB3";
      ring-color = "#CBA6F7";
      key-hl-color = "#F5C2E7";
      bs-hl-color = "#F38BA8";
      text-color = "#CDD6F4";

      inside-ver-color = "#1E1E2EB3";
      ring-ver-color = "#89B4FA";
      text-ver-color = "#89B4FA";

      inside-wrong-color = "#1E1E2EB3";
      ring-wrong-color = "#F38BA8";
      text-wrong-color = "#F38BA8";

      inside-clear-color = "#1E1E2EB3";
      ring-clear-color = "#A6E3A1";
      text-clear-color = "#A6E3A1";

      inside-caps-lock-color = "#1E1E2EB3";
      ring-caps-lock-color = "#FAB387";
      text-caps-lock-color = "#FAB387";

      # Nothing to separate now that the ring carries the colour.
      line-color = "#00000000";
      line-ver-color = "#00000000";
      line-wrong-color = "#00000000";
      line-clear-color = "#00000000";
      line-caps-lock-color = "#00000000";
      separator-color = "#00000000";

      layout-bg-color = "#1E1E2EE6";
      layout-border-color = "#CBA6F7";
      layout-text-color = "#CDD6F4";
    };
  };
}
