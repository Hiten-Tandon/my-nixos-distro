{
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    extra-experimental-features = [ "pipe-operators" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    wezterm.url = "github:wez/wezterm?dir=nix";
    flake-utils.url = "github:numtide/flake-utils";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:hiten-tandon/twilight-zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-stable,
      zen-browser,
      stylix,
      flake-utils,
      nix-flatpak,
      ...
    }:
    let
      system = "x86_64-linux";
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      config = fromTOML (builtins.readFile ./config.toml);
      stylix-enabled = config.misc.stylix-enabled or true;
      user = config.user;
      flatpak-enabled = config.misc.flatpak-enabled or true;
      zen = zen-browser.packages.${system}.default;
    in
    {
      nixosConfigurations.${user.name} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit (inputs)
            pandoc-plot
            fdm
            wezterm
            neovim-nightly-overlay
            spicetify-nix
            ;
          inherit
            user
            stable
            zen
            stylix-enabled
            ;
          inherit (config) system;
        };
        modules = [
          ./config
        ]
        ++ (nixpkgs.lib.optional stylix-enabled stylix.nixosModules.stylix)
        ++ (nixpkgs.lib.optional flatpak-enabled nix-flatpak.nixosModules.nix-flatpak);
      };

    }
    // flake-utils.lib.eachDefaultSystem (
      system: with import nixpkgs { inherit system; }; {
        formatter = nixfmt-tree;
      }
    );
}
