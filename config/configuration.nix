{
  user,
  pkgs,
  system,
  zen,
  stable,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./stylix.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-experimental-features = [ "pipe-operators" ];
    substituters = [
      "https://wezterm.cachix.org"
      "https://cache.iog.io"
      "https://cosmic.cachix.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  time.timeZone = system.time-zone;

  virtualisation = {
    vmVariant.virtualisation = {
      memorySize = 8192;
      cores = 8;
      diskSize = 128 * 1024;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with pkgs; [ linuxPackages_latest.v4l2loopback.out ];
    kernelModules = [
      "v4l2loopback"
      "snd-aloop"
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  security = {
    doas.enable = true;
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };

  services = {
    cron.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
    };
    displayManager = {
      gdm.enable = system.dm == "gdm";
      sddm = {
        enable = system.dm == "sddm";
        wayland.enable = system.dm == "sddm";
      };
      cosmic-greeter = {
        enable = system.dm == "cosmic-greeter";
        package = stable.cosmic-greeter;
      };
    };
    desktopmanager = {
      plasma6.enable = user.de == "kde";
      cosmic = {
        enable = user.de == "cosmic";
        xwayland.enable = user.de == "cosmic";      
      };
      gnome.enable = user.de == "gnome";
    };
    fwupd.enable = true;
    printing.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
  };

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = {
    hostName = if user.display-name == null then user.name else user.display-name;
    networkmanager.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_ALL = "en_US.UTF-8";
  };

  environment = {
    sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    stub-ld.enable = true;
    systemPackages = with pkgs; [
      lact
      git
    ];
  };

  systemd = {
    packages = [ pkgs.lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

  programs = {
    steam = {
      enable = false;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ gmp ];
    };
    kdeconnect.enable = false;
  };

  users.users.${user.name} = {
    isNormalUser = true;
    initialPassword = user.initial-password;
    description = user.display-name;
    shell = pkgs.${user.shell or "bash"};
    extraGroups = [
      "networkmanager"
    ]
    ++ (pkgs.lib.optional user.sudo "wheel");
    packages = with pkgs; [
      zen
      gcc
      clang-tools
      cmake
      ghostty
      gnumake
      home-manager
      git
      signal-desktop
    ];
  };

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig.defaultFonts.monospace = [ "JetBrainsMono" ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-cosmic ];
  };

  system.stateVersion = "24.11";
}
