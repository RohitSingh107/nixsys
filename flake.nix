{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    firefox-addons = {
      url = "gitlab:/rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rofi-conf = {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
      flake = false;
    };

    # nur = {
    #   url = github:nix-community/NUR;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };


  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };


    in
    {
      nixosConfigurations = {
        # Different Hosts 
        rohits = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {

              home-manager = {

                extraSpecialArgs = { inherit inputs; };



                useGlobalPkgs = true;
                useUserPackages = true;
                # Can have different conf for fifferent users
                users.rohits = {
                  imports = [
                    ./home
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
