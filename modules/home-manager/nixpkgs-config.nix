# Writes ~/.config/nixpkgs/config.nix, the config the *ad-hoc* nix commands
# read -- `nix run nixpkgs#foo --impure`, `nix shell`, `nix-shell`, `nix-build`,
# `nix-env`.
#
# The `nixpkgs.config` block in each host's home.nix does NOT cover those: it
# only configures the nixpkgs instance home-manager evaluates for this profile.
# The nixpkgs flake's `legacyPackages` calls `import ./.` (pkgs/top-level/
# impure.nix) without a `config` argument, so nixpkgs falls back to
# $NIXPKGS_CONFIG, else $HOME/.config/nixpkgs/config.nix. Both are read through
# builtins.getEnv, which returns "" under pure evaluation -- hence flake
# commands still need `--impure` for this file to be seen at all. That flag is
# unavoidable; what this file removes is the per-invocation
# NIXPKGS_ALLOW_UNFREE=1.
{...}: {
  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';
}
