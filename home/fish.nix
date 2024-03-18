{ pkgs, ... }: {


  programs.fish = {
    enable = true;
    # interactiveShellInit = "
    #   cowsay -r -C 'Hello Rohit'
    #   ";

    shellInit = ''
      set -g fish_greeting
      '';

    shellAbbrs = {
      gco = "git checkout";
      l = "less";
      gcm = "git commit -m";
    };

    shellAliases = {
      # ls = "eza -al --color=always --group-directories-first --icons"; # preferred listing
      # la = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
      ip = "ip -color";
      # ll = "eza -l --color=always --group-directories-first --icons"; # long format
      # lt = "eza -aT --color=always --group-directories-first --icons"; # tree listing
      "l." = "eza -a | egrep '^\.'"; # show only dotfiles



      # Common use
      grubup = "sudo update-grub";
      fixpacman = "sudo rm /var/lib/pacman/db.lck";
      tarnow = "tar -acf ";
      untar = "tar -xvf ";
      # wget = "wget -c ";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head - 10";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hw = "hwinfo --short";
      icat = "kitty +kitten icat";


      # Get the error messages from journalctl
      jctl = "journalctl -p 3 -xb";

    };

    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
  };


}
