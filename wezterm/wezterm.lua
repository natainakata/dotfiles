local wezterm = require 'wezterm'

local default_keybinds = {
  { key = 'p', mods = 'ALT', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
  { key = 'q', mods = 'ALT', action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
  { key = "x", mods = "ALT", action = "ActivateCopyMode" },
}


local launch_menu = {}


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end

  -- Enumerate any WSL distributions that are installed and add those to the menu
  local success, wsl_list, wsl_err =
    wezterm.run_child_process { 'wsl.exe', '-l' }
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

return {
  font = wezterm.font("HackGenNerd Console"),
  use_ime = true,
  font_size = 14.0,
  color_scheme = "nightfox",
  window_background_opacity = 0.7,
  adjust_window_size_when_changing_font_size = false,
  -- disable_default_key_bindings = true,
  default_prog = { 'pwsh.exe', '-NoLogo' },
  keys = default_keybinds,
  launch_menu = launch_menu
}
