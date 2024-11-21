local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.term = "wezterm"
config.font = wezterm.font_with_fallback({ "JetBrains Mono Nerd Font" })
config.window_background_opacity = 0.6
config.font_size = 15
config.enable_wayland = true
return config
