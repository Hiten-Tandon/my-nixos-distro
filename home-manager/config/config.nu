$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.PATH = $env.PATH | append ["/var/lib/flatpak/exports/bin"]
$env.XDG_CONFIG_DIRS = $"($env.XDG_CONFIG_DIRS):($env.HOME)/.config"
$env.EDITOR = "hx"

alias vi = hx
alias vim = hx
alias ncim = hx
alias nvim = hx
alias helix = hx
alias fuckoff = exit

export def nixos-rbld [ --update-flake --uf ] {
  rm -rf $"($env.HOME)/.gtkrc-2.0"
  cd $"($env.HOME)/projects/nixos-config/my-config"
  if $update_flake or $uf {
    sudo nix flake update
  }
  sudo nixos-rebuild switch --flake $".#((open config.toml).user.name)" --impure
  if ((git status --short) | str length) != 0 {
    lazygit
  }
}

fastfetch
