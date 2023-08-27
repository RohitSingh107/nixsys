{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    firefox-addons = {
      url = "gitlab:/rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur = {
    #   url = github:nix-community/NUR;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # xr = {
    #   url = github:RohitSingh107/xmobar-hs-nix;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #


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
        # Can have different conf for fifferent users
        rohits = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            # nur.nixosModules.nur
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {

              home-manager = {

                extraSpecialArgs = { inherit inputs; };



                useGlobalPkgs = true;
                useUserPackages = true;
                users.rohits = {
                  imports = [
                    ./home
                    # hyprland.homeManagerModules.default
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
