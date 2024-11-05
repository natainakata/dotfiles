local utils = require("rc.utils")

local M = {}

function M.on_attach(client, bufnr)
  utils.autocmd("LspFormatting", "BufWritePre", { "*.rs", "*.py", "*.ts" }, function()
    vim.lsp.buf.format({
      buffer = bufnr,
      filter = function(client)
        return client.name ~= "null-ls"
      end,
      async = false,
    })
  end)
end

return M
