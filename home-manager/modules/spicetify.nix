{
  nixpkgs,
  unstable,
  spicetify-nix,
  ...
}:
let
  pkgs = unstable;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  nixpkgs.config.allowUnfree = true;
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.sleek;
    colorScheme = "RosePine";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      fullAppDisplay
      keyboardShortcut
      powerBar
      beautifulLyrics
      volumePercentage
    ];
  };
}
