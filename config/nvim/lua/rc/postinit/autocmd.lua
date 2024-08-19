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

autocmd("mclang", { "BufRead", "BufNewFile" }, "*.lang", "set filetype=mclang")

if is_nvim() then
  autocmd("luasnip_history", "ModeChanged", "*", function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end)
end

autocmd("use_easy_regname", "TextYankPost", nil, function()
  if vim.v.event.regname == "" then
    vim.fn.setreg(vim.v.event.oparator, vim.fn.getreg())
  end
end)
