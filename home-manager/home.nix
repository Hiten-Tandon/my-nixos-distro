spicePkgs: inputs:
{ stable, user, pkgs, ... }: {
  imports = [ ./fastfetch.nix (import ./spicetify.nix spicePkgs inputs) ];
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
      stable.contour
      kdePackages.qtstyleplugin-kvantum
      kde-rounded-corners
      element-desktop
      element-web-unwrapped
      vesktop
      wl-clipboard
    ];
    file = {
      ".config/contour/contour.yml".source = ./contour.yml;
      ".config/contour/default_contour.yml".source = ./default_contour.yml;
      ".config/nvim" = {
        source = ./nvim-config;
        recursive = true;
      };
    };
    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    gh.enable = true;
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
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
    zellij = {
      enable = true;
      settings = {
        theme = "ayu_dark";
        ui.pane_frames.rounded_corners = true;
        on_force_close = "quit";
        default_layout = "compact";
      };
    };
  };
}
