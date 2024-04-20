{pkgs, ...}: let
  browser = "firefox";
  image_viewer = "org.gnome.Loupe"; # loupe
  file_manager = "org.gnome.Nautilus";
in {

  xdg = {
    enable = true;
    mime.enable = true;

    portal = {
      enable = true;
      configPackages = [pkgs.gnome.gnome-session];
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
    };

    mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = ["${file_manager}.desktop"];
        "x-scheme-handler/http" = ["${browser}.desktop"];
        "x-scheme-handler/https" = ["${browser}.desktop"];
        "x-scheme-handler/chrome" = ["${browser}.desktop"];
      };
      defaultApplications = {
        "inode/directory" = ["${file_manager}.desktop"];
        "x-scheme-handler/http" = ["${browser}.desktop"];
        "x-scheme-handler/https" = ["${browser}.desktop"];
        "x-scheme-handler/chrome" = ["${browser}.desktop"];
        "application/pdf" = ["org.gnome.Evince.desktop" "${browser}.desktop"];
        "image/png" = ["${image_viewer}.desktop"];
        "image/jpg" = ["${image_viewer}.desktop"];
        "image/jpeg" = ["${image_viewer}.desktop"];
      };
    };
  };
}
