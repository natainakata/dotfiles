return {
  root_dir = require("lspconfig.util").root_pattern(".git"),
  settings = {
    groovy = {
      classpath = {
        "./mods/",
      },
    },
  },
}
