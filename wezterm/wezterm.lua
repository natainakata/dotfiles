local wezterm = require("wezterm")
local utils = require("utils")
local keybind = require("keybind")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
  {
    family = "0xProto",
    weight = "Regular",
    stretch = "Normal",
    italic = false,
  },
  { family = "BIZ UDGothic", weight = "Regular", stretch = "Normal", style = "Normal" },
})
config.use_ime = true
config.font_size = 13.0
config.command_palette_font_size = 13.0

config.initial_cols = 120
config.initial_rows = 30
config.color_scheme = "OneDark (base16)"

config.window_background_opacity = 0.85
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

config.adjust_window_size_when_changing_font_size = false
config.default_prog = wezterm.target_triple == "x86_64-pc-windows-msvc" and { "pwsh.exe" } or { "zsh" }

config.default_cwd = os.getenv("HOME")
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keybind.create_keybinds()
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  table.insert(config.launch_menu, {
    label = "PowerShell",
    args = { "pwsh.exe", "-NoLogo" },
  })
  table.insert(config.launch_menu, {
    label = "Builtin PowerShell",
    args = { "powershell.exe", "-NoLogo" },
  })
  table.insert(config.launch_menu, {
    label = "Neovim",
    args = { "nvim.exe" },
  })
  for _, domain in ipairs(wezterm.default_wsl_domains()) do
    table.insert(config.launch_menu, {
      label = domain["name"],
      args = {
        "wsl.exe",
        "--distribution",
        domain["distribution"],
      },
      cwd = "/home/natai",
    })
  end
else
  table.insert(config.launch_menu, {
    label = "Bash",
    args = { "bash", "-l" },
  })
  table.insert(config.launch_menu, {
    label = "Zsh",
    args = { "zsh", "-l" },
  })
  table.insert(config.launch_menu, {
    label = "NeoVim",
    args = { "nvim" },
  })
end

wezterm.on("update-status", function(window, pane)
  local wday = os.date("*t").wday
  local wday_ja = string.format("(%s)", utils.day_of_week_ja(wday))
  local date = wezterm.strftime("󰃮  %Y-%m-%d " .. wday_ja .. " 󰥔  %H:%M:%S")

  local bat = ""

  for _, b in ipairs(wezterm.battery_info()) do
    local battery_state_of_charge = b.state_of_charge * 100
    local battery_icon = ""
    if battery_state_of_charge >= 80 then
      battery_icon = "80  "
    elseif battery_state_of_charge >= 70 then
      battery_icon = "70  "
    elseif battery_state_of_charge >= 60 then
      battery_icon = "60  "
    elseif battery_state_of_charge >= 50 then
      battery_icon = "50  "
    elseif battery_state_of_charge >= 40 then
      battery_icon = "40  "
    elseif battery_state_of_charge >= 30 then
      battery_icon = "30  "
    elseif battery_state_of_charge >= 20 then
      battery_icon = "20  "
    else
      battery_icon = "󱊡  "
    end

    bat = string.format("%s%.0f%% ", battery_icon, battery_state_of_charge)
  end

  window:set_right_status(wezterm.format({
    { Text = date },
  }))
end)

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1
  local edge_background = "#31353f"
  local background = "#393f4a"
  local foreground = "#abb2bf"

  if tab.is_active then
    background = "#393f4a"
    foreground = "#abb2bf"
  elseif hover then
    background = "#3b3052"
    foreground = "#909090"
  end
  local title = tab_title(tab)
  -- return {}
  if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") then
    return string.format(" %d %s ", tab_index, "Copy mode...")
  end
  return string.format(" %d ", tab_index)
end)

return config
