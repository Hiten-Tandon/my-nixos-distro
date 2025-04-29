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
    wezterm.url = "github:wez/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";
    zen-browser = {
      # url = "github:hiten-tandon/twilight-zen-browser-flake";
      url = "gitlab:invranet/zen-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pandoc-plot.url = "github:hiten-tandon/pandoc-plot-flake";
    fdm.url = "github:hiten-tandon/freedownloadmanager-nix";
  };

  outputs = {
    pandoc-plot,
    nixpkgs-stable,
    nixpkgs,
    home-manager,
    spicetify-nix,
    stylix,
    zen-browser,
    wezterm,
    nix-flatpak,
    fdm,
    neovim-nightly-overlay,
    ...
  }: let
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
  in {
    nixosConfigurations.${user.name} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          (import ./config/configuration.nix user config.system stable zen)
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${user.name} = import ./home-manager/home.nix;
              extraSpecialArgs = {
                inherit
                  pkgs
                  user
                  unstable
                  stable
                  spicetify-nix
                  wezterm
                  zen
                  pandoc-plot
                  fdm
                  neovim-nightly-overlay
                  stylix-enabled
                  ;
                username = user.name;
              };
            };
          }
        ]
        ++ (pkgs.lib.optional stylix-enabled stylix.nixosModules.stylix)
        ++ (pkgs.lib.optional flatpak-enabled nix-flatpak.nixosModules.nix-flatpak);
    };

    formatter.${system} = pkgs.alejandra;
  };
}
