local helper = require("rc.utils.lsp")
return {
  init_options = {
    enableProfileLoading = false,
  },

  settings = {
    powershell = {
      codeFormatting = {
        preset = "OTBS",
        newLineAfterOpenBrace = false,
        newLineAfterCloseBrace = true,
      },
    },
  },
  on_attach = helper.on_attach(function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end),
}
