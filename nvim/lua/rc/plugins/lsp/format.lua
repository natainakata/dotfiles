local utils = require("lazy.core.util")

local M = {}

M.autoformat = true

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    utils.info("Enabled format on save", { title = "Format" })
  else
    utils.warn("Disabled format on save", { title = "Format" })
  end
end

function M.on_attach(client, buf)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormat" .. buf, {}),
    buffer = buf,
    callback = function()
      if M.autoformat then
        vim.cmd("Format")
      end
    end
  })
end

return M
