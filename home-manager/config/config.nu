$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.PATH = $env.PATH | append ["/var/lib/flatpak/exports/bin"]
$env.XDG_CONFIG_DIRS = $"($env.XDG_CONFIG_DIRS):($env.HOME)/.config"
$env.EDITOR = "nvim"

export def nixos-rbld [] {
  let currDir = $"(pwd)"
  rm -rf $"($env.HOME)/.gtkrc-2.0"
  cd $"($env.HOME)/projects/nixos-config/my-config"
  sudo nix flake update
  sudo nixos-rebuild switch --flake $".#((open config.toml).user.name)" --impure
  lazygit
  cd $currDir
}

fastfetch
