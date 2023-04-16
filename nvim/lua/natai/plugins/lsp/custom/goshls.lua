local util = require("lspconfig.util")
return {
  default_config = {
    cmd = { "/home/natai/sandbox/goshls/goshls" },
    filetypes = { "text" },
    root_dir = util.path.dirname,
  },
  docs = {
    description = [[
        Language Server Protocol for gauche.
      ]],
    default_config = {
      root_dir = [[root_pattern(".git")]],
    },
  },
  settings = {},
}
