{
  pandoc-plot,
  zen,
  fdm,
  wezterm,
  neovim-nightly-overlay,
  user,
  lib,
  stylix-enabled,
  unstable,
  ...
}:
let
  pkgs = unstable;
in
{
  imports = [ ./modules ] ++ (lib.optional stylix-enabled ../config/stylix.nix);
  stylix.targets.starship.enable = false;
  home = {
    username = user.name;
    homeDirectory = "/home/" + user.name;
    stateVersion = "24.11";
    packages = with pkgs; [
      lua-language-server
      luarocks
      lua
      nil
      ffmpeg
      lazygit
      markdownlint-cli2
      marksman
      fzf
      bash-language-server
      kdePackages.qtstyleplugin-kvantum
      kde-rounded-corners
      element-desktop
      element-web-unwrapped
      vesktop
      mermaid-filter
      mermaid-cli
      librsvg
      wl-clipboard
      nushellPlugins.polars
      pandoc
      texliveFull
      zen
      pandoc-plot.outputs.packages.${pkgs.system}.default
      fdm.outputs.packages.${pkgs.system}.default
      signal-desktop
      deno
      license-go
      codesnap
    ];
    file = {
      ".config/nvim" = {
        source = ./config/nvim-config;
        recursive = true;
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
    btop = {
      enable = true;
      package = pkgs.btop-rocm;
      settings = {
        update_ms = 100;
        temp_scale = "kelvin";
      };
    };
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
      };
    };
    wezterm = {
      enable = true;
      package = wezterm.packages.${pkgs.system}.default;
      extraConfig = builtins.readFile ./config/wezterm.lua;
    };
    nushell = {
      enable = true;
      configFile.source = ./config/config.nu;
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./config/starship.toml);
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
      package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
