-------------------------------------------
-- THIS FILE GOES INTO ~/.confg/wezterm/ --
-------------------------------------------
-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()
local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

------------------------------------
-- Wezterm schema for sessionizer --
------------------------------------
-- Ensure zoxide is in PATH

local history = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer-history.git")

local schema = {
	options = {
		callback = history.Wrapper(sessionizer.DefaultCallback),
	},
	sessionizer.DefaultWorkspace({}),
	history.MostRecentWorkspace({}),

	wezterm.home_dir .. "/.dotfiles",
	-- wezterm.home_dir .. "/.nixos-config",
	-- wezterm.home_dir .. "/.config/wezterm",
	-- wezterm.home_dir .. "/.config/nvim",
	-- wezterm.home_dir .. "/.config/sway",
	-- wezterm.home_dir .. "/.config/waybar",
	-- wezterm.home_dir .. "/.config/ags",
	-- wezterm.home_dir .. "/Uni",
	-- wezterm.home_dir .. "/desktop/FullStackOpen",

	sessionizer.FdSearch({
		wezterm.home_dir .. "/Desktop",
		fd_path = "C:/Users/user/AppData/Local/Microsoft/WinGet/Packages/sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe/fd-v10.3.0-x86_64-pc-windows-msvc/fd.exe",
	}),
	-- sessionizer.FdSearch(wezterm.home_dir .. "/Uni"),

	processing = sessionizer.for_each_entry(function(entry)
		entry.label = entry.label:gsub(wezterm.home_dir, "~")
	end),
}

local smart_workspace_switcher_replica = {
	options = {
		prompt = "Workspace to switch: ",
		callback = history.Wrapper(sessionizer.DefaultCallback),
	},
	{
		sessionizer.AllActiveWorkspaces({
			filter_current = false,
			filter_default = false,
		}),
		processing = sessionizer.for_each_entry(function(entry)
			entry.label = wezterm.format({ {
				Text = "󱂬 : " .. entry.label,
			} })
		end),
	},
	-- wezterm.plugin.require("https://github.com/mikkasendke/sessionizer-zoxide.git").Zoxide({}),
	-- processing = sessionizer.for_each_entry(function(entry)
	--     entry.label = entry.label:gsub(wezterm.home_dir, "~")
	-- end)
}

wezterm.on("update-status", function(window, pane)
	-- Active workspace name
	local active_ws = window:active_workspace()

	-- Collect workspaces from history + sessionizer
	local entries = sessionizer.AllActiveWorkspaces({
		filter_current = false,
		filter_default = false,
	})()

	local cells = {}
	for _, e in ipairs(entries) do
		if e.id == active_ws then
			table.insert(
				cells,
				wezterm.format({
					{
						Foreground = {
							Color = "#bea3c7",
						},
					},
					{
						Text = " [" .. e.label .. "] ",
					},
				})
			)
		else
			table.insert(
				cells,
				wezterm.format({
					{
						Foreground = {
							Color = "#888888",
						},
					},
					{
						Text = " " .. e.label .. " ",
					},
				})
			)
		end
	end

	-- Put the workspace list on the LEFT side of the status bar
	window:set_left_status(table.concat(cells, " "))
end)

config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

-- config.font = wezterm.font("JetBrainsMono NF")
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("Monocraft Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font Mono")
-- config.font = wezterm.font("JetBrains Mono Regular")
config.cell_width = 0.9
-- config.font = wezterm.font("Menlo Regular")
-- config.font = wezterm.font("Hasklig")
-- config.font = wezterm.font("Monoid Retina")
-- config.font = wezterm.font("InputMonoNarrow")
-- config.font = wezterm.font("mononoki Regular")
-- config.font = wezterm.font("Iosevka")
-- config.font = wezterm.font("M+ 1m")
-- config.font = wezterm.font("Hack Regular")
-- config.cell_width = 0.9
config.window_background_opacity = 0.8
config.prefer_egl = true
config.font_size = 14.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true

-- config.inactive_pane_hsb = {
-- 	saturation = 0.0,
-- 	brightness = 1.0,
-- }

-- This is where you actually apply your config choices
--

-- color scheme toggling
wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "Zenburn" then
		overrides.color_scheme = "Cloud (terminal.sexy)"
	else
		overrides.color_scheme = "Zenburn"
	end
	window:set_config_overrides(overrides)
end)

-- keymaps
config.keys = {
	{
		key = "E",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.EmitEvent("toggle-colorscheme"),
	}, -- {
	-- 	key = "h",
	-- 	mods = "CTRL|SHIFT|ALT",
	-- 	action = wezterm.action.SplitPane({
	-- 		direction = "Right",
	-- 		size = {
	-- 			Percent = 50,
	-- 		},
	-- 	}),
	-- },
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	}, -- {
	-- 	key = "v",
	-- 	mods = "CTRL|SHIFT|ALT",
	-- 	action = wezterm.action.SplitPane({
	-- 		direction = "Down",
	-- 		size = {
	-- 			Percent = 50,
	-- 		},
	-- 	}),
	-- },
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "U",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "I",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "O",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "9",
		mods = "CTRL",
		action = act.PaneSelect,
	},
	{
		key = "L",
		mods = "CTRL|SHIFT|ALT",
		action = act.ShowDebugOverlay,
	},
	{
		key = "O",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.8
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action({
			ActivatePaneDirection = "Left",
		}),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action({
			ActivatePaneDirection = "Right",
		}),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action({
			ActivatePaneDirection = "Up",
		}),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action({
			ActivatePaneDirection = "Down",
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action({
			CloseCurrentPane = {
				confirm = true,
			},
		}),
	},
	{
		key = "z",
		mods = "ALT",
		action = sessionizer.show(schema),
	},
	{
		key = "i",
		mods = "ALT|SHIFT",
		action = sessionizer.show(smart_workspace_switcher_replica),
	},
	{
		key = "o",
		mods = "ALT|SHIFT",
		action = history.switch_to_most_recent_workspace,
	},
}

-- For example, changing the color scheme:
config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	-- background = '#3b224c',
	-- background = "#181616", -- vague.nvim bg
	-- background = "#080808", -- almost black
	background = "#0c0b0f", -- dark purple
	-- background = "#020202", -- dark purple
	-- background = "#17151c", -- brighter purple
	-- background = "#16141a",
	-- background = "#0e0e12", -- bright washed lavendar
	-- background = 'rgba(59, 34, 76, 100%)',
	cursor_border = "#bea3c7",
	-- cursor_fg = "#281733",
	cursor_bg = "#bea3c7",
	-- selection_fg = '#281733',

	tab_bar = {
		background = "#0c0b0f",
		-- background = "rgba(0, 0, 0, 0%)",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#bea3c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			-- bg_color = "rgba(59, 34, 76, 50%)",
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}

config.window_frame = {
	font = wezterm.font({
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
	}),
	active_titlebar_bg = "#0c0b0f",
	-- active_titlebar_bg = "#181616",
}

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "NONE | RESIZE"
-- config.default_prog = { "powershell.exe", "-NoLogo" }
config.default_prog = { "cmd.exe", "/k", "cls" }
config.initial_cols = 80
-- config.window_background_image = "C:/dev/misc/berk.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	-- window:gui_window():maximize()
-- 	-- window:gui_window():set_position(0, 0)
-- end)

-- and finally, return the configuration to wezterm
return config
