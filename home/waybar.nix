
{ pkgs, ... }: {

  programs.waybar = {
    enabled = true;
    package = (pkgs.waybar.override (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          }));
  };


}
