local wezterm = require 'wezterm'
local utils = require 'utils'
local act = wezterm.action

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' },
  })

  -- Enumerate any WSL distributions that are installed and add those to the menu
  local success, wsl_list, wsl_err =
    wezterm.run_child_process { 'wsl.exe', '-l'}
  -- `wsl.exe -l` has a bug where it always outputs utf16:
  -- https://github.com/microsoft/WSL/issues/4607
  -- So we get to convert it
  wsl_list = wezterm.utf16_to_utf8(wsl_list)

  for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
    -- Skip the first line of output; it's just a header
    if idx > 1 then
      -- Remove the "(Default)" marker from the default line to arrive
      -- at the distribution name on its own
      local distro = line:gsub(' %(既定%)', '')

      -- Add an entry that will spawn into the distro with the default shell
      table.insert(launch_menu, {
        label = distro .. ' (WSL default shell)',
        args = { 'wsl.exe', '--distribution', distro },
      })
    end
  end
end


wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
  if title == "" then
    title = wezterm.truncate_right(utils.convert_home_dir(tab.active_pane.current_working_dir), max_width)
  end
  return {
    { Text = tab.tab_index + 1 .. ':' .. title },
  }
end)

local default_keybinds = {
  { key = 'p', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
  { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
  { key = 'n', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },
  { key = 'q', mods = 'LEADER', action = act({ CloseCurrentTab = { confirm = false } }) },
  { key = 'x', mods = 'LEADER', action = 'ActivateCopyMode' },
  { key = 's', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'p', mods = 'LEADER|SHIFT', action = act.PaneSelect },
  { key = 'x', mods = 'LEADER|SHIFT', action = act.CloseCurrentPane { confirm = false } },
}

return {
  font = wezterm.font_with_fallback {
    "HackGenNerd Console",
  },
  use_ime = true,
  font_size = 14.0,
  color_scheme = "Sonokai (Gogh)",
  window_background_opacity = 0.8,
  adjust_window_size_when_changing_font_size = false,
  -- disable_default_key_bindings = true,
  default_prog = { 'pwsh.exe', '-NoLogo' },
  leader = { key = '\\', mods = 'ALT', timeout_milliseconds = 1000 },
  keys = default_keybinds,
  launch_menu = launch_menu
}
