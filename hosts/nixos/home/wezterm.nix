{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];

  home.file.".config/wezterm/wezterm.lua".text = ''
	-- Pull in the wezterm API
	local wezterm = require 'wezterm'
	local workspace = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

	-- Pull the extra config files
	-- local window_resize_event = require('extra.format_tab_event')
	-- This table will hold the configuration.
	local config = {}

	-- In newer versions of wezterm, use the config_builder which will
	-- help provide clearer error messages
	if wezterm.config_builder then
		config = wezterm.config_builder()
	end

	-- This is where you actually apply your config choices

	-- Fonts
	-- config.font = wezterm.font { family = 'Liga SFMono Nerd Font' }
	config.font = wezterm.font { family = 'GeistMono Nerd Font' }

	-- Ligatures
	config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

	-- Color Scheme
	config.color_scheme = 'Kanagawa (Gogh)'

	-- Cursor style
	config.default_cursor_style = 'BlinkingBar'

	-- Animation FPS (for the cursor)
	config.animation_fps = 120

	-- Window background opacity
	config.window_background_opacity = 0.85 config.macos_window_background_blur = 0
	-- Tab bar
	config.tab_bar_at_bottom = false
	config.tab_max_width = 22
	config.show_new_tab_button_in_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = true
	config.window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		-- font = wezterm.font {
		--	family = 'Liga SFMono Nerd Font',
		--	weight = 'Bold',
		--	harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }
		-- },

		-- The size of the font in the tab bar.
		-- Default to 10.0 on Windows but 12.0 on other systems
		font_size = 14.0,
	}


	config.colors = {
	tab_bar = {
	background = "rgba(255,255,0,0)",

		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = "#111317",
			fg_color = "#e0def4",
			italic = true,
		},

		-- Inactive tabs are the tabs that don't have focus
			inactive_tab = {
				bg_color = "#111317",
				fg_color = "#6e6a86",
				intensity = "Half",
			}
		}
	}

	-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

	-- Command palette
	config.command_palette_font_size = 16.0
	config.command_palette_fg_color = "#908caa"
	config.command_palette_bg_color = "#191724"
	config.keys = {
		{
			key = 'P',
			mods = 'CTRL',
			action = wezterm.action.ActivateCommandPalette,
		},
	}

	config.window_padding = {
		top = 0,
		left = 0,
		right = 0
	}

	-- BackSlash issue
	-- @see https://github.com/wez/wezterm/issues/4051

	config.send_composed_key_when_right_alt_is_pressed = true
	config.send_composed_key_when_left_alt_is_pressed = true

	local act = wezterm.action

	config.keys = {
		{ key = "/", mods = "SHIFT|ALT", action = wezterm.action({ SendString = "\\" }) },
		-- other keyaps ...
		{
			key = "S",
			mods = "CTRL",
			action = workspace.switch_workspace(),
		},
		{
			key = "Space",
			mods = "SHIFT",
			action = act.PaneSelect,
		}
	}

	-- and finally, return the configuration to wezterm

	workspace.apply_to_config(config)
	-- timeout_milliseconds defaults to 1000 and can be omitted
	config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

	-- timeout_milliseconds defaults to 1000 and can be omitted
	return config
	'';
}
