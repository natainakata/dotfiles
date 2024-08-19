local utils = require("rc.utils")
local telescope = require("telescope.builtin")
local M = {}
M._keys = nil

-- function M.get()
--   if not M._keys then
--     M._keys = {
--       { , desc = "References" },
--       {  desc = "Definition" },
--       { , desc = "Type definition" },
--       { , mode = { "n", "x" }, desc = "Code Action", has = "codeAction" },
--       {  desc = "Next Diagnostic" },
--       { "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
--       -- { "R", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
--       -- { "K", vim.lsp.buf.hover, desc = "Hover" },
--       -- { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
--       -- { "<C-k>", vim.lsp.buf.signature_help, mode = { "i" }, desc = "Signature Help", has = "signatureHelp" },
--     }
--   end
--   return M._keys
-- end

function M.on_attach(_, buffer)
  utils.nmap("<Leader>lr", function()
    telescope.lsp_references()
  end, { silent = true, buffer = buffer, desc = "References" })
  utils.nmap("<Leader>ld", function()
    telescope.lsp_definitions()
  end, { silent = true, buffer = buffer, desc = "Definitions" })
  utils.nmap("<Leader>lt", function()
    telescope.lsp_type_definitions()
  end, { silent = true, buffer = buffer, desc = "Type Definitions" })
  vim.keymap.set({ "n", "x" }, "<Leader>la", function()
    vim.lsp.buf.code_action()
  end, { silent = true, buffer = buffer, desc = "Code Action" })
  utils.nmap("<Leader>le", function()
    telescope.diagnostics()
  end)
  utils.nmap("g]", function()
    vim.diagnostic.get_next()
  end, { silent = true, buffer = buffer, desc = "Next Diagnositc" })
  utils.nmap("g[", function()
    vim.diagnostic.get_prev()
  end, { silent = true, buffer = buffer, desc = "Prev Diagnositc" })
  utils.nmap("R", function()
    vim.lsp.buf.rename()
  end, { silent = true, buffer = buffer, desc = "Rename" })
  utils.nmap("K", function()
    vim.lsp.buf.hover()
  end, { silent = true, buffer = buffer, desc = "Hover Document" })
  utils.nmap("<Leader>lk", function()
    vim.lsp.buf.signature_help()
  end, { silent = true, buffer = buffer, desc = "Signature Help" })
  utils.imap("<C-k>", function()
    vim.lsp.buf.signature_help()
  end, { silent = true, buffer = buffer, desc = "Signature Help" })
  -- utils.nmap("<Leader>F", function()
  --   vim.lsp.buf.format()
  -- end, { silent = true, buffer = buffer, desc = "Format" })
end

return M
