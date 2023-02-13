local wezterm = require('wezterm')
local utils = require('utils')
local keybind = require('keybind')

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' }
  })
  table.insert(launch_menu, {
    label = 'Builtin PowerShell',
    args = { 'powershell.exe', '-NoLogo' }
  })
  for idx, domain in ipairs(wezterm.default_wsl_domains()) do
    table.insert(launch_menu, {
      label = domain['name'],
      args = {
        'wsl.exe', '--distribution', domain['distribution']
      }
    })
  end
end

local colors, metadata = wezterm.color.load_base16_scheme('C:/Users/natai/.dotfiles/colors/sonokai.yaml')
return {
  font = wezterm.font_with_fallback {
    "HackGen35 Console NF",
  },
  use_ime = true,
  font_size = 13.0,
  -- color_scheme = "Sonokai (Gogh)",
  colors = colors,
  window_background_opacity = 0.8,
  adjust_window_size_when_changing_font_size = false,
  -- disable_default_key_bindings = true,
  default_prog = { 'pwsh.exe', '-NoLogo' },
  leader = { key = '\\', mods = 'ALT', timeout_milliseconds = 1000 },
  keys = keybind.create_keybinds(),
  launch_menu = launch_menu
}
