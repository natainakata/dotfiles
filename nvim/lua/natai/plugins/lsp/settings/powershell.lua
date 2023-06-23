local utils = require("natai.util")
return {
  mason = false,
  settings = {
    powershell = {
      codeFormatting = {
        preset = "OTBS",
        newLineAfterOpenBrace = false,
        newLineAfterCloseBrace = true,
      },
    },
  },
  on_attach = utils.on_attach(function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end),
}
