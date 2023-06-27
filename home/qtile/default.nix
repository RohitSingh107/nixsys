{ pkgs, ... }: {

  home.file = {
    ".config/qtile" = {
      source = ./.;
      recursive = true;
    };
  };
}
