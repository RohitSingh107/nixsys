# /run/opengl-driver on a SELinux-enforcing non-NixOS host (Fedora).
#
# home-manager's targets.genericLinux.gpu already builds the driver env and
# ships a `non-nixos-gpu-setup` helper, but that helper symlinks its systemd
# unit out of /nix into /etc/systemd/system and calls `systemctl enable`. Under
# enforcing SELinux that fails -- /nix is labelled default_t and PID 1
# (init_t) may not read a unit file with that label:
#
#   Failed to enable unit: Access denied
#   AVC avc: denied { read } for pid=1 comm="systemd" name="non-nixos-gpu.service"
#     scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:default_t:s0
#
# The unit only runs `ln -nsf <drivers> /run/opengl-driver`, and creating a
# symlink never reads its target, so nothing genuinely needs to read /nix as
# init_t -- relabelling the whole store to appease systemd would be a large
# hammer for a non-problem. A tmpfiles.d rule does the same job from /etc,
# which is etc_t and readable.
#
# The rule points at a stable symlink in $HOME rather than at the store path,
# so a `home-manager switch` that bumps mesa repoints the drivers by itself and
# the root-owned file never goes stale. Run the setup helper once per machine:
#
#   sudo "$(command -v nix-gpu-tmpfiles-setup)"
#
# See docs/fedora-gpu-drivers.md for the full story.
#
# NOTE: upstream's `non-nixos-gpu-setup` stays on PATH (it is what GC-roots the
# driver env). Ignore it -- it is the command that does not work here.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.targets.genericLinux.gpu;

  stableLink = "${config.home.homeDirectory}/.local/state/gpu-drivers";

  tmpfilesConf = pkgs.writeText "nix-opengl-driver.conf" ''
    # Installed by nix-gpu-tmpfiles-setup, from
    # modules/home-manager/non-nixos-gpu-selinux.nix -- edits here are lost on
    # the next run of that script.
    #
    # Nix-built GL apps hunt for driver ICDs under /run/opengl-driver, the path
    # NixOS uses. The target is a symlink home-manager repoints on every
    # switch, so this file stays correct across mesa updates.
    L+ /run/opengl-driver - - - - ${stableLink}
  '';

  setup = pkgs.writeShellApplication {
    name = "nix-gpu-tmpfiles-setup";
    text = ''
      if [ "$(id -u)" -ne 0 ]; then
        echo "nix-gpu-tmpfiles-setup: needs root, try:" >&2
        echo "  sudo $0" >&2
        exit 1
      fi

      if [ ! -e "${stableLink}" ]; then
        echo "nix-gpu-tmpfiles-setup: ${stableLink} is missing -- run" >&2
        echo "  home-manager switch --flake .#rohit@fedora" >&2
        echo "first, then re-run this." >&2
        exit 1
      fi

      # Undo a previous run of upstream's helper, whose unit either failed to
      # enable or now competes with the tmpfiles rule for /run/opengl-driver.
      if [ -e /etc/systemd/system/non-nixos-gpu.service ]; then
        echo "removing upstream non-nixos-gpu.service (superseded by tmpfiles.d)"
        systemctl disable --quiet non-nixos-gpu.service 2>/dev/null || true
        rm -f /etc/systemd/system/non-nixos-gpu.service
        rm -f /nix/var/nix/gcroots/non-nixos-gpu.service
        systemctl daemon-reload
      fi

      conf=/etc/tmpfiles.d/nix-opengl-driver.conf
      install -m 644 ${tmpfilesConf} "$conf"
      # install(1) copies the source context on some coreutils builds; make the
      # label match the /etc/tmpfiles.d policy either way.
      command -v restorecon >/dev/null && restorecon "$conf"

      systemd-tmpfiles --create "$conf"
      echo "/run/opengl-driver -> $(readlink -f /run/opengl-driver)"
    '';
  };
in {
  # The stable indirection the tmpfiles rule points at.
  home.file.".local/state/gpu-drivers".source = cfg.drivers;

  home.packages = [setup];

  # Upstream's check compares `readlink /run/opengl-driver` against the store
  # path, which never matches once the symlink goes through stableLink -- it
  # would nag on every switch. Resolve the whole chain instead, and run after
  # linkGeneration so we are looking at the drivers this generation just
  # installed rather than the previous ones.
  home.activation.checkExistingGpuDrivers = lib.mkForce (lib.hm.dag.entryAfter ["linkGeneration"] ''
    existing=$(readlink -f /run/opengl-driver || true)
    verboseEcho "Existing drivers: $existing"
    verboseEcho "New drivers: ${cfg.drivers}"
    if [ -z "$existing" ]; then
      warnEcho "This host has no /run/opengl-driver, so Nix GUI apps will not"
      warnEcho "find a GPU. To set it up (once per machine), run"
      warnEcho "  sudo ${lib.getExe setup}"
    elif [ "$existing" != "${cfg.drivers}" ]; then
      warnEcho "/run/opengl-driver resolves to $existing,"
      warnEcho "not this generation's ${cfg.drivers}."
      warnEcho "If the tmpfiles rule was lost, reinstate it with"
      warnEcho "  sudo ${lib.getExe setup}"
    fi
  '');
}
