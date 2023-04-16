{
  description = "A very basic flake";

  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	home-manager.url = "github:nix-community/home-manager";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  
  outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
    	inherit system;
    	config.allowUnfree = true;
    };
    in {
    	nixosConfigurations = {
	        # Can have different conf for fifferent users
    		rohits = nixpkgs.lib.nixosSystem {
    			inherit system;
    			modules = [ 
			./system/configuration.nix 
			home-manager.nixosModules.home-manager {
				    home-manager.useGlobalPkgs = true;
				    home-manager.useUserPackages = true;
				    home-manager.users.rohits = import ./home/home.nix; 
				  }
			];
    		};
    	};

    };


  
}
