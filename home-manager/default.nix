{
  user,
  pandoc-plot,
  fdm,
  wezterm,
  neovim-nightly-overlay,
  pkgs,
  unstable,
  stable,
  spicetify-nix,
  zen,
  stylix-enabled,
  home-manager,
  ...
}:
{
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = false;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${user.name} = import ./home.nix;
        extraSpecialArgs = {
          inherit
            pandoc-plot
            fdm
            wezterm
            neovim-nightly-overlay
            pkgs
            user
            unstable
            stable
            spicetify-nix
            zen
            stylix-enabled
            ;
          username = user.name;
        };
      };
    }
  ];
}
