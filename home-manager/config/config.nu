$env.config.show_banner = false;
$env.config.use_kitty_protocol = true;
$env.PATH = $env.PATH | append [ "/var/lib/flatpak/exports/bin" ]
$env.NIX_USER_CONF_FILES = $"($env.HOME)/.config/nix"
$env.EDITOR = "hx"

alias vi = hx
alias vim = hx
alias ncim = hx
alias nvim = hx
alias helix = hx
alias fuckoff = exit

# clone a repo
export def --env clone-repo [
  repo: string, # The service provider and repo to clone (ex: github:Hiten-Tandon/my-nixos-distro)
  target?: string, # The target directory
  --https, # Use https protocol instead of the default ssh
  --cd(-c) # cd into the target after cloning
] {
  let url = if $https {
    $repo | str replace -r "(.*):(.*)" "https://${1}.com/${2}"
  } else {
    $repo | str replace -r "(.*):(.*)" "git@${1}.com:${2}"
  }

  let target = if ($target == null) {
    $repo | str replace -r ".*/(.*)" "${1}"
  } else {
    $target
  }

  git clone $url $target
  if $cd {
    cd $target
  }
}

# Rebuild nixos config
# Example:
# ```
#   nixos-rbld -u
# ```
export def nixos-rbld [
  --update-flake(-u) # Update the flake before updating the configuration
] {
  rm -rf $"($env.HOME)/.gtkrc-2.0"
  cd $"($env.HOME)/projects/nixos-config/my-config"
  if $update_flake {
    sudo nix flake update
  }
  sudo nixos-rebuild switch --flake $".#((open config.toml).user.name)" --impure
  if ((git status --short) | str length) != 0 {
    lazygit
  }
}

fastfetch
