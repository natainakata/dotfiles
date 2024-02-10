return {
  ssh_domains = {},

  unix_domains = {},

  wsl_domains = {
    {
      name = "WSL:Ubuntu",
      distribution = "Ubuntu",
      username = "natai",
      default_cwd = "/home/natai",
      default_prog = { "fish" },
    },
  },
}
