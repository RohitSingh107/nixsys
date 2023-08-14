{ pkgs, ... }: {
  enable = true;
  enableCompletion = true;
  sessionVariables = {
    PS1 = "\[\e[91m\][\[\e[m\]\[\e[32m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[91m\]]\$\[\e[0m\]";
  };
  shellAliases = {
    ls = "exa -al --color=always --group-directories-first --icons"; # preferred listing
    la = "exa -a --color=always --group-directories-first --icons"; # all files and dirs
    ip = "ip -color";
    ll = "exa -l --color=always --group-directories-first --icons"; # long format
    lt = "exa -aT --color=always --group-directories-first --icons"; # tree listing
    "l." = "exa -a | egrep '^\.'"; # show only dotfiles



    # Common use
    grubup = "sudo update-grub";
    fixpacman = "sudo rm /var/lib/pacman/db.lck";
    tarnow = "tar -acf ";
    untar = "tar -xvf ";
    wget = "wget -c ";
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
  # bash.bashrcExtra = ''
  #
  # # Bash Prompt
  # export PS1="\[\e[91m\][\[\e[m\]\[\e[32m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[91m\]]\$\[\e[0m\]"
  #   '';


}
