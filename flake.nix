{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs-stable, nixpkgs, home-manager, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      config = (builtins.fromTOML (builtins.readFile ./config.toml));
      user = config.user;
      spicePkgs = spicetify-nix.legacyPackages.${system};
    in {
      nixosConfigurations.${user.name} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./config/configuration.nix user config.system)
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} =
                (import ./home-manager/home.nix spicePkgs inputs);
              extraSpecialArgs = {
                inherit pkgs stable user;
                username = user.name;
              };
            };
          }
        ];
      };

      formatter.${system} = pkgs.nixfmt-classic;
    };
}
