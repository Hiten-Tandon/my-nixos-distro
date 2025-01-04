user: system:
{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./stylix.nix ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://wezterm.cachix.org" "https://cache.iog.io" ];
    trusted-public-keys = [
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };

  time.timeZone = system.time-zone;

  virtualisation.vmVariant.virtualisation = {
    memorySize = 8192;
    cores = 8;
    diskSize = 128 * 1024;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
      displayManager.gdm.enable = system.dm == "gdm";
    };
    displayManager.sddm = {
      enable = system.dm == "sddm";
      wayland.enable = system.dm == "sddm";
    };
    desktopManager.plasma6.enable = true;
    fwupd.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
    openssh.enable = true;
  };

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = {
    hostName =
      (if user.display-name == null then user.name else user.display-name);
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  environment.stub-ld.enable = true;
  programs.nix-ld.enable = true;

  users.users.${user.name} = {
    isNormalUser = true;
    initialPassword = user.initial-password;
    description = user.display-name;
    shell = pkgs.${user.shell or "bash"};
    extraGroups = [ "networkmanager" ]
      ++ (if user.sudo or true then [ "wheel" ] else [ ]);
    packages = with pkgs; [ brave kitty gcc clang-tools cmake gnumake ];
  };

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig.defaultFonts.monospace = [ "JetBrainsMono" ];
  };

  system.stateVersion = "24.11";
}
