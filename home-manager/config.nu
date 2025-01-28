$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;

export def nixos-rbld [] {
  let currDir = $"(pwd)"
  rm -rf $"($env.HOME)/.gtkrc-2.0"
  cd $"($env.HOME)/projects/my-config"
  sudo nix flake update
  sudo nixos-rebuild switch --flake $".#((open config.toml).user.name)"
  cd $currDir
}

fastfetch
