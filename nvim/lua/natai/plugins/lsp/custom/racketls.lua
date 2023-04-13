local util = require("lspconfig.util")
return {
  default_config = {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "scheme", "racket" },
    root_dir = util.path.dirname,
  },
  docs = {
    description = [[
        https://github.com/jeapostrophe/racket-langserver
        Language Server Protocol fo Racket.
      ]],
    default_config = {
      root_dir = [[root_pattern(".git")]],
    },
  },
  settings = {},
}
