{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmic-de = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs =
    inputs@{ nixpkgs-stable, nixpkgs, home-manager, spicetify-nix, cosmic-de, ... }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = unstable;
      config = (builtins.fromTOML (builtins.readFile ./config.toml));
      user = config.user;
      spicePkgs = spicetify-nix.legacyPackages.${system};
    in {
      nixosConfigurations.${user.name} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          cosmic-de.nixosModules.default
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
                inherit pkgs user unstable stable;
                username = user.name;
              };
            };
          }
        ];
      };

      formatter.${system} = pkgs.nixfmt-classic;
    };
}
