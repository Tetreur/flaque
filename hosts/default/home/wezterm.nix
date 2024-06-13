{
  pkgs,
  config,
  lib,
  host,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];

  home.file.".config/wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'

    -- This will hold the config
    local config =  wezterm.config_builder()

    -- Fonts
    config.font = wezterm.font { family = 'GeistMonoNerdFont' }

    -- Ligatures
    config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

    -- Color Scheme
    config.color_scheme = 'Kanagawa (Gogh)'

    -- Cursor style
    config.default_cursor_style = 'BlinkingBar'
    config.animation_fps = 120

    -- Window bg opacity & blur
    config.window_background_opacity = 0.85

    -- Tab bar
    config.show_new_tab_button_in_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.window_frame = {
    	-- The font used in tab bar
    	font = wezterm.font {
    		family = 'GeistMonoNerdFont',
    		weight = 'Bold',
    		harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    	},

    	font_size = 14.0,
    }

    config.colors = {
    	tab_bar = {
    		background = "rgba(255,255,0,0)",
    	},
    }

    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

    config.enable_wayland = false

    return config
  '';
}
