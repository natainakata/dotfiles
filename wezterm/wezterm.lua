local status, wezterm = pcall(require, "wezterm")
if not status then
	return
end
local utils = require("utils")
local keybind = require("keybind")

wezterm.on("update-status", function(window, pane)
	local wday = os.date("*t").wday
	local wday_ja = string.format("(%s )", utils.day_of_week_ja(wday))
	local date = wezterm.strftime("📆  %Y-%m-%d " .. wday_ja .. " ⏰  %H:%M:%S")

	local bat = ""

	for _, b in ipairs(wezterm.battery_info()) do
		local battery_state_of_charge = b.state_of_charge * 100
		local battery_icon = ""
		if battery_state_of_charge >= 80 then
			battery_icon = "🌕  "
		elseif battery_state_of_charge >= 70 then
			battery_icon = "🌖  "
		elseif battery_state_of_charge >= 60 then
			battery_icon = "🌖  "
		elseif battery_state_of_charge >= 50 then
			battery_icon = "🌗  "
		elseif battery_state_of_charge >= 40 then
			battery_icon = "🌗  "
		elseif battery_state_of_charge >= 30 then
			battery_icon = "🌘  "
		elseif battery_state_of_charge >= 20 then
			battery_icon = "🌘  "
		else
			battery_icon = "🌑  "
		end

		bat = string.format("%s%.0f%% ", battery_icon, battery_state_of_charge)
	end

	window:set_right_status(wezterm.format({
		{ Text = date .. " " .. bat },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1
	if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") then
		return string.format(" %d %s ", tab_index, "Copy mode...")
	end
	return string.format(" %d ", tab_index)
end)

local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "Builtin PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	for idx, domain in ipairs(wezterm.default_wsl_domains()) do
		table.insert(launch_menu, {
			label = domain["name"],
			args = {
				"wsl.exe",
				"--distribution",
				domain["distribution"],
			},
		})
	end
end

local default_cwd = os.getenv("HOME")

local colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

return {
	font = wezterm.font_with_fallback({
		{ family = "UDEV Gothic 35NFLG", weight = "Regular" },
		{ family = "JetBrainsMono NFM", weight = "Regular" },
	}),
	use_ime = true,
	font_size = 14.0,
	-- color_scheme = "Sonokai (Gogh)",
	-- color_scheme = "kanagawa (Gogh)",
	colors = colors,
	window_background_opacity = 0.9,
	adjust_window_size_when_changing_font_size = false,
	-- disable_default_key_bindings = true,
	default_prog = { "pwsh.exe" },
	default_cwd = default_cwd,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keybind.create_keybinds(),
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	launch_menu = launch_menu,
}
