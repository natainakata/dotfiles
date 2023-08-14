local wezterm = require("wezterm")
local utils = require("utils")
local keybind = require("keybind")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
  { family = "UDEV Gothic 35NFLG", weight = "Regular", stretch = "Normal", style = "Normal" },
})
config.use_ime = true
config.font_size = 13.0
config.command_palette_font_size = 13.0

config.initial_cols = 120
config.initial_rows = 30
config.color_scheme = "Catppuccin Frappe"

config.window_background_opacity = 0.85
config.adjust_window_size_when_changing_font_size = false
-- config.default_prog = wezterm.target_triple == "x86_64-pc-windows-msvc" and { "pwsh.exe" } or { "zsh" }

-- config.default_cwd = wezterm.home_dir
config.disable_default_key_bindings = true
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keybind.create_keybinds()
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.launch_menu = {}
config.enable_wayland = false

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
  -- local title = string.format(" %s %s ", pane:get_title(), utils.basename(pane:get_current_working_dir()))
  -- local title = string.format(" %s ", pane.title)
  local date = wezterm.strftime(" 󰃮  %Y-%m-%d " .. wday_ja .. " 󰥔  %H:%M:%S")
  local fg = "#303446"
  local title_bg = "#a6d189"
  local date_bg = "#85c1dc"
  window:set_right_status(wezterm.format({
    -- { Background = { Color = title_bg } },
    -- { Foreground = { Color = fg } },
    -- { Text = title },
    { Background = { Color = date_bg } },
    { Foreground = { Color = fg } },
    { Text = date },
  }))
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
  local tab_index = tab.tab_index + 1
  local title = string.format(" %d ", tab_index)
  local bg = "#292c3c"
  local fg = "#c6d0f5"
  if tab.is_active then
    bg = "#ef9f76"
    fg = "#303446"
  end
  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = title },
  }
end)

return config
