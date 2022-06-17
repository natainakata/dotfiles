local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("rc/lsp/handlers").on_attach,
    capabilities = require("rc/lsp/handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("rc/lsp/sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end
  if server.name == "arduino_language_server" then
    local arduino_opts = require("rc/lsp/arduino")
    opts = vim.tbl_deep_extend("force", arduino_opts, opts)
  end

  if server.name == "tsserver" or server.name == "eslint" then
    local node_opts = require("rc/lsp/node")
    opts = vim.tbl_deep_extend("force", node_opts, opts)
  elseif server.name == "denols" then
    local deno_opts = require("rc/lsp/deno")
    opts = vim.tbl_deep_extend("force", deno_opts, opts)
  end
  if server.name == "emmet_ls" then
    local emmet_opts = require("rc/lsp/emmet")
    opts = vim.tbl_deep_extend("force", emmet_opts, opts)
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)


