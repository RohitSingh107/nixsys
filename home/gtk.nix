
{ pkgs, ... }: {

  gtk = {
    # Theming
    enable = true;
    cursorTheme = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 18;

    };
    theme = {
      # name = "Dracula";
      # package = pkgs.dracula-theme;
      name = "Catppuccin-Mocha-Standard-Red-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "red" ];
        size = "standard";
        # tweaks = [ "rimless" "normal" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      #name = "JetBrains Mono Medium";
      name = "FiraCode Nerd Font Mono Medium";
      # size = "8";
    }; # Cursor is declared under home.pointerCursor


  };

}
