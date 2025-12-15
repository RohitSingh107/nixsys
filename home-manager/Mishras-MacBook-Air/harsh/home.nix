{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ../../../modules/home-manager/alacritty.nix
    # ../../../modules/home-manager/kitty.nix
    # ../../../modules/home-manager/fish.nix
    # ../../../modules/home-manager/tmux.nix
    # ../../../modules/home-manager/xdg.nix
    # ../../../modules/home-manager/starship.nix
    # ../../../modules/home-manager/vscode.nix
    # ../../../modules/home-manager/nvim
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "harsh";
    homeDirectory = "/Users/harsh";
    stateVersion = "23.05"; 

    packages = with pkgs; [
      ripgrep
      eza
      fzf
      jq
      neofetch
      # Add other packages here
    ];
  };

  programs = {
    home-manager.enable = true;
    
    git = {
      enable = true;
      userName = "Harsh";
      userEmail = "harsh@example.com";
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };
  };
}

