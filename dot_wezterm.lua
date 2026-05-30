local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true

config.initial_cols = 120
config.initial_rows = 30

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font_size = 14
config.color_scheme = "GruvboxDark"

config.font = wezterm.font("Monaspace Neon NF")
config.harfbuzz_features = {
	"calt=1",
	"liga=1",
	"ss01=1",
	"ss02=1",
	"ss03=1",
	"ss04=1",
	"ss05=1",
	"ss06=1",
	"ss07=1",
	"ss08=1",
	"ss09=1",
	"ss10=1",
}

return config
