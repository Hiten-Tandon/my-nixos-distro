{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm.url = "github:wez/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:hiten-tandon/twilight-zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pandoc-plot.url = "github:hiten-tandon/pandoc-plot-flake";
    fdm.url = "github:hiten-tandon/freedownloadmanager-nix";
    flake-utils.url = "github:numtide/flake-utils";
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
      unstable = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = unstable;
      config = builtins.fromTOML (builtins.readFile ./config.toml);
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
            home-manager
            pandoc-plot
            fdm
            wezterm
            neovim-nightly-overlay
            spicetify-nix
            ;
          inherit
            user
            unstable
            stable
            zen
            stylix-enabled
            ;
          system = config.system;
        };
        modules =
          [
            ./config
            ./home-manager
          ]
          ++ (pkgs.lib.optional stylix-enabled stylix.nixosModules.stylix)
          ++ (pkgs.lib.optional flatpak-enabled nix-flatpak.nixosModules.nix-flatpak);
      };

    }
    // flake-utils.lib.eachDefaultSystem (
      system: with import nixpkgs { inherit system; }; {
        formatter = nixfmt-tree;
      }
    );
}
