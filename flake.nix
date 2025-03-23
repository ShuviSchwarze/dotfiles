{
  description = "Home Manager configuration of shuvi";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    # substituters = ["https://hyprland.cachix.org"];
    # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  #
  # nix.settings = {
  # };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flatpaks support
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
  };

  outputs = { self, nixpkgs, home-manager, flatpaks, ... } @ inputs:
    let
      inherit (self) outputs;
      # systems = [
      #   "aarch64-linux"
      #   "i686-linux"
      #   "x86_64-linux"
      #   "aarch64-darwin"
      #   "x86_64-darwin"
      # ];
      
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      homeConfigurations = {
        "shuvi" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ 
            flatpaks.homeManagerModules.declarative-flatpak
            ./home.nix 
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {inherit inputs outputs;};
        };
      };
    };
}
