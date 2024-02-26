local wezterm = require("wezterm")
local platform = require("utils").platform()
local options = {
  default_prog = {},
  launch_menu = {},
}

if platform.is_win then
  options.default_prog = { "pwsh" }
  options.launch_menu = {
    {
      label = "PowerShell",
      args = { "pwsh.exe" },
    },
    {
      label = "Builtin PowerShell",
      args = { "powershell.exe" },
    },
  }
  -- for _, domain in ipairs(wezterm.default_wsl_domains()) do
  --   table.insert(options.launch_menu, {
  --     label = domain["name"],
  --     args = {
  --       "wsl.exe",
  --       "--distribution",
  --       domain["distribution"],
  --     },
  --     cwd = "/home/natai",
  --   })
  -- end
elseif platform.is_linux then
  options.default_prog = { "zsh" }
  options.launch_menu = {
    { label = "Bash", args = { "bash" } },
    { label = "Fish", args = { "fish" } },
    { label = "Zsh",  args = { "zsh" } },
  }
end

return options
