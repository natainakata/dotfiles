local wezterm = require("wezterm")
local platform = require("utils").platform()

local domains = {
  wsl_domains = {},
  ssh_domains = {},
  unix_domains = {},
}

if platform.is_win then
  local wsl_domains = wezterm.default_wsl_domains()

  for idx, dom in ipairs(wsl_domains) do
    if dom.name == "WSL:Ubuntu" then
      dom.default_prog = { "zsh" }
    end
  end
  domains.wsl_domains = wsl_domains
  domains.default_domain = "WSL:Ubuntu"
end

return domains
