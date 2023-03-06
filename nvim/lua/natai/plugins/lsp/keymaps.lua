local M = {}
M._keys = nil

function M.get()
  local format = require("natai.plugins.lsp.format").format
  local telescope = require("telescope.builtin")
  if not M._keys then
    M._keys = {
      { "<Leader>F", format, desc = "Format Document", has = "documentFormatting" },
      { "<Leader>F", format, desc = "Format",          mode = "v",                has = "documentFormatting" },
      {
        "<Leader>lr",
        function()
          telescope.lsp_references()
        end,
        desc = "References",
      },
      {
        "<Leader>ld",
        function()
          telescope.lsp_definitions()
        end,
        desc = "Definition",
      },
      { "<Leader>lD", vim.lsp.buf.declaration,                   desc = "Declaration" },
      {
        "<Leader>li",
        function()
          telescope.lsp_implementations()
        end,
        desc = "Implementation",
      },
      {
        "<Leader>lt",
        function()
          telescope.lsp_type_definitions()
        end,
        desc = "Type Definition",
      },
      {
        "<Leader>le",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Open Diagnostic",
      },
      { "g]",         "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
      { "g[",         "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
      { "<Leader>la", vim.lsp.buf.code_action,                   desc = "Action",         mode = { "n", "v" },     has = "codeAction" },
      { "<F2>",       vim.lsp.buf.hover,                         desc = "Rename",         has = "rename" },
      { "K",          vim.lsp.buf.hover,                         desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,                desc = "Signature Help", has = "signatureHelp" },
      { "<C-k",       vim.lsp.buf.signature_help,                mode = "i",              desc = "Signature Help", has = "signatureHelp" },
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
