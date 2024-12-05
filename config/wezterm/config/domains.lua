local wezterm = require("wezterm")
local platform = require("utils").platform()

local domains = {
  wsl_domains = {},
  ssh_domains = {},
  unix_domains = {},
}

if platform.is_win then
  domains.wsl_domains = wezterm.default_wsl_domains()
  domains.default_domain = "WSL:Ubuntu"
end

return domains
