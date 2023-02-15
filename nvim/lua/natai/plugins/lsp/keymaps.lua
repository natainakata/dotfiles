local M = {}
M._keys = nil

function M.get()
  if not M._keys then
    M._keys = {
      { "<Leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", desc = "Format" },
      { "<Leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
      { "<Leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition" },
      { "<Leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
      { "<Leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
      { "<Leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type Definition" },
      { "<Leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
      { "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Action" },
      {
        "<Leader>le",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Open Diagnostic",
      },
      { "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
      { "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
    }
  end
  return M._keys
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(M.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

return M
