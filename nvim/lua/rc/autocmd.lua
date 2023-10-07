local utils = require("rc.utils")
local autocmd = utils.autocmd

autocmd("term_insert_in", "TermOpen", nil, function()
  vim.opt_local.number = false
  vim.cmd.startinsert()
end)

autocmd("highlight_yank", "TextYankPost", nil, function()
  vim.highlight.on_yank()
end)

autocmd("close_with_q", "FileType", {
  "quickrun",
  "qf",
  "help",
  "man",
  "notify",
  "lspinfo",
}, function(event)
  vim.bo[event.buf].buflisted = false
  vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
end)

autocmd("cmdwin_close", "CmdwinEnter", nil, function(event)
  vim.bo[event.buf].buflisted = false
  vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
end)

autocmd("qf_position", "FileType", "qf", "wincmd H")

autocmd("vimgrep_autoopen", "QuickFixCmdPost", "vimgrep", function()
  vim.cmd.cwindow()
  vim.bo.modifiable = true
  vim.cmd("vertical resize 70")
end)
