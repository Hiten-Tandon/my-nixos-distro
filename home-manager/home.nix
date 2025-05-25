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
  stylix.targets = {
    starship.enable = false;
    yazi.enable = false;
    helix.enable = false;
  };
  home = {
    username = user.name;
    homeDirectory = "/home/" + user.name;
    stateVersion = "24.11";
    packages = with pkgs; [
      ffmpeg
      lazygit
      fzf
      kdePackages.qtstyleplugin-kvantum
      kde-rounded-corners
      element-desktop
      element-web-unwrapped
      vesktop
      mermaid-filter
      mermaid-cli
      librsvg
      wl-clipboard
      pandoc
      texliveFull
      zen
      pandoc-plot.outputs.packages.${pkgs.system}.default
      fdm.outputs.packages.${pkgs.system}.default
      glab
      signal-desktop
      license-go
      codesnap
    ];
  };

  programs = {
    ripgrep.enable = true;
    home-manager.enable = true;
    git.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "rose_pine";
        editor = {
          line-number = "relative";
          scrolloff = 100;
          mouse = false;
          popup-border = "all";
          end-of-line-diagnostics = "hint";
          cursor-shape.insert = "bar";
          indent-guides.render = true;
          inline-diagnostics.cursor-line = "warning";
          insert-final-newline = false;
          lsp = {
            display-inlay-hints = true;
            display-progress-messages = true;
          };
          auto-save = {
            focus-lost = true;
            after-delay.enable = true;
          };
        };
      };
      extraPackages = with pkgs; [
        nil
        nixd
        marksman
        bash-language-server
        markdownlint-cli2
        marksman
      ];
    };
    btop = with pkgs; {
      enable = true;
      package = btop-rocm;
      settings = {
        update_ms = 100;
        temp_scale = "kelvin";
      };
    };
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
        browser = "${zen}/bin/zen";
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
