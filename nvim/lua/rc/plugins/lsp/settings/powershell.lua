local utils = require("rc.utils")
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
  on_attach = utils.lsp.on_attach(function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end),
}
