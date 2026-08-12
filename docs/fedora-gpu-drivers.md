# Fedora: GPU drivers for Nix-built GUI apps

**Symptom** — `kitty` (or any Nix-built GL app) dies immediately on the Fedora host:

```
[0.119] [glfw error 65542]: EGL: Failed to initialize EGL: An EGLDisplay argument
does not name a valid EGL display connection display_present: 0 egl_platform_present: 0
Segmentation fault (core dumped) kitty
```

## Why it happens

Nix's `libglvnd`, `vulkan-loader` and `mesa` are all patched to look for driver ICDs
under `/run/opengl-driver` — the path NixOS' `hardware.graphics` creates. The search
path is baked into `libEGL.so`:

```
/run/opengl-driver/share/glvnd/egl_vendor.d:/etc/glvnd/egl_vendor.d:/usr/share/glvnd/egl_vendor.d
```

Fedora has no `/run/opengl-driver`, so kitty falls through to Fedora's
`/usr/share/glvnd/egl_vendor.d/50_mesa.json`, tries to `dlopen` the *system*
`libEGL_mesa.so.0` against *Nix's* glvnd, and `eglInitialize` fails. kitty then
segfaults on the way out — the crash is a red herring, the EGL error is the real fault.

Same root cause would hit mpv (`vo=gpu`), chromium and firefox.

## What upstream gives you

`targets.genericLinux.enable = true` in `home-manager/fedora/rohit/home.nix` turns on
home-manager's `targets.genericLinux.gpu` module by default (it keys off
`genericLinux.enable && nixGL.packages == null`). That module:

- builds the driver env — mesa + `intel-media-driver` + VA-API/VDPAU backends,
  the same shape NixOS' `hardware.graphics` builds;
- installs a `non-nixos-gpu-setup` helper into the profile;
- warns during activation if `/run/opengl-driver` is missing or stale.

That covers everything a user-level home-manager switch can do. Creating
`/run/opengl-driver` needs root, so it is left to the helper — which is where Fedora
diverges.

## The SELinux catch

`sudo non-nixos-gpu-setup` fails on Fedora:

```
Failed to enable unit: Access denied
```

The helper symlinks its unit out of the store into `/etc/systemd/system` and runs
`systemctl enable`. `/nix` is labeled `default_t`, and PID 1 (`init_t`) may not read a
unit file with that label:

```
AVC avc: denied { read } for pid=1 comm="systemd" name="non-nixos-gpu.service"
scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
```

The helper assumes an unconfined system. Don't relabel the whole store to work around
this — the unit only runs `ln -nsf <drivers> /run/opengl-driver`, and creating a symlink
never reads its target, so nothing actually needs to read `/nix` as `init_t`.

## The fix — tmpfiles.d instead of a unit

`/etc/tmpfiles.d/*.conf` is `etc_t`, which `systemd-tmpfiles` reads without complaint,
and it recreates the symlink on every boot. That is what
`modules/home-manager/non-nixos-gpu-selinux.nix` sets up. It keeps upstream's
`targets.genericLinux.gpu` module for the driver env itself and adds three things:

- a stable symlink, `~/.local/state/gpu-drivers` → the driver env, repointed by every
  `home-manager switch`;
- a generated tmpfiles conf whose target is that stable symlink, not a store path, so
  the root-owned file never goes stale;
- `nix-gpu-tmpfiles-setup`, which installs the conf, fixes its SELinux label and applies
  it — and along the way removes any `non-nixos-gpu.service` left by upstream's helper,
  which would otherwise fight over `/run/opengl-driver`.

It also `mkForce`s upstream's `checkExistingGpuDrivers` activation check. That check
compares `readlink /run/opengl-driver` against the store path, which can never match once
the symlink goes through the stable link, so it would nag on every switch. The
replacement resolves the whole chain with `readlink -f` and runs `entryAfter
["linkGeneration"]`, so it inspects the drivers this generation just installed rather
than the previous ones.

**Run once per machine**, after a `home-manager switch`:

```bash
sudo "$(command -v nix-gpu-tmpfiles-setup)"
```

The `$(...)` is needed because `sudo`'s `secure_path` does not include
`~/.nix-profile/bin`.

Takes effect immediately, no reboot.

Dropping the helper's gcroot is safe: the driver env store path appears in the
`non-nixos-gpu` unit text, making it a reference of that package, and that package is in
the home profile — so the home-manager generation keeps it alive. The stable symlink
gives it a second root.

## Maintenance

None. A `nix flake update` that bumps mesa is picked up by the next `home-manager
switch`, which repoints `~/.local/state/gpu-drivers`; the tmpfiles conf points at the
symlink and does not change. Only rerun the setup command if `/etc/tmpfiles.d` is wiped
(a reinstall, say) — activation will tell you when that has happened.

One consequence of routing through `$HOME`: `/home/rohit` is `0700`, so only this user's
processes can traverse to the drivers. Nix GUI apps run by another user on this machine
would still find nothing. That is fine for a single-user laptop; a multi-user host wants
the conf pointing straight at the store path instead, and root reruns on every mesa bump.

## Diagnosing

`eglinfo` from `nixpkgs#mesa-demos` is the quickest probe, since it's a Nix-built binary
with the same broken search path:

```bash
nix run nixpkgs#mesa-demos -- eglinfo -B      # wrong: "eglInitialize failed"
```

Working output on this machine (Intel Raptor Lake-P, Iris Xe, GNOME Wayland):

```
Wayland platform:
EGL vendor string: Mesa Project
OpenGL core profile renderer: Mesa Intel(R) Iris(R) Xe Graphics (RPL-P)
```

You can test a candidate driver env without root by faking the search paths, which is
useful for confirming the env is good before touching `/etc`:

```bash
__EGL_VENDOR_LIBRARY_DIRS=$DRIVERS/share/glvnd/egl_vendor.d \
  LIBGL_DRIVERS_PATH=$DRIVERS/lib/dri eglinfo -B
```

GBM will still fail under that trick — `/run/opengl-driver/lib/gbm` is hardcoded in mesa
with no env override — but EGL/Wayland initializing is enough to confirm the env.
