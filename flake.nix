{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs = {

      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #
    # ec = {
    #
    #   url = "github:RohitSingh107/example-c";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };


  outputs = inputs@{ self, nixpkgs, home-manager, nix-doom-emacs, nur, ... }:
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
            nur.nixosModules.nur
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.rohits = {
                imports = [
                  ./home
                  nix-doom-emacs.hmModule
                ];
              };
            }
          ];
        };
      };
    };
}
