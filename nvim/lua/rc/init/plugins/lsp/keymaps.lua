local utils = require("rc.utils")
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

function M.on_attach(client, buffer)
  local opts = {}
  opts.has = nil
  opts.silent = true
  opts.buffer = buffer
  utils.nmap("gr", "<Cmd>Ddu lsp:references<CR>", opts)
  utils.nmap("gd", "<Cmd>Ddu lsp:definition<CR>", opts)
  utils.nmap("gt", "<Cmd>Ddu lsp:type_definition<CR>", opts)
  vim.keymap.set({ "n", "x" }, "<Leader>a", "<Cmd>Ddu lsp:code_action<CR>", opts)
  utils.nmap("g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  utils.nmap("g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  utils.nmap("R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  utils.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  utils.nmap("gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  utils.imap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

return M
