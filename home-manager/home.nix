spicePkgs: inputs:
{ stable, user, pkgs, ... }: {
  imports = [
    ./fastfetch.nix
    (import ./spicetify.nix spicePkgs inputs)
    ../config/stylix.nix
  ];
  home = {
    username = user.name;
    homeDirectory = "/home/" + user.name;
    stateVersion = "24.11";
    packages = with pkgs; [
      lua-language-server
      luarocks
      lua
      nil
      obs-studio
      ffmpeg
      lazygit
      markdownlint-cli2
      marksman
      fzf
      btop
      bash-language-server
      kdePackages.qtstyleplugin-kvantum
      kde-rounded-corners
      element-desktop
      element-web-unwrapped
      vesktop
      wl-clipboard
      kdevelop
      nushellPlugins.polars
      pandoc_3_6
      texliveFull
    ];
    file = {
      ".config/nvim" = {
        source = ./nvim-config;
        recursive = true;
      };
      ".config/starship.toml" = {
        source = ./starship.toml;
      };
    };
    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
    };
  };

  programs = {
    lf.enable = true;
    ripgrep.enable = true;
    home-manager.enable = true;
    git.enable = true;
    gh = {
      enable = true;
      settings = { editor = "nvim"; };
    };
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
