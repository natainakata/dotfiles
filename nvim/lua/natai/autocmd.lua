local utils = require("natai.utils")
local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  group = utils.augroup("term_insert_in"),
  callback = function()
    vim.opt_local.number = false
    vim.cmd.startinsert()
  end,
})

autocmd("TextYankPost", {
  group = utils.augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("FileType", {
  group = utils.augroup("close_with_q"),
  pattern = {
    "quickrun",
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd("CmdwinEnter", {
  group = utils.augroup("cmdwinclose"),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  group = utils.augroup("qf_position"),
  pattern = "qf",
  command = "wincmd H",
})

autocmd("QuickFixCmdPost", {
  group = utils.augroup("vimgrep_autoopen"),
  pattern = "vimgrep",
  callback = function()
    vim.cmd([[
      cw
      set modifiable
      vertical resize 30
    ]])
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = utils.augroup("mclang"),
  pattern = "*.lang",
  command = "set filetype=mclang",
})
autocmd("CursorMoved", {
  group = utils.augroup("redraw_line"),
  command = "redrawtabline",
})

-- if vim.loop.os_uname().sysname == "Windows_NT" then
--   autocmd({ "InsertLeave", "CmdlineLeave" }, {
--     group = utils.augroup("disable_ime"),
--     callback = function()
--       vim.fn.system("zenhan 0")
--     end,
--   })
-- elseif vim.loop.os_uname().sysname == "Linux" then
--   if vim.fn.system("uname -a | grep microsoft") then
--     autocmd({ "InsertLeave", "CmdlineLeave" }, {
--       group = utils.augroup("disable_ime"),
--       callback = function()
--         vim.fn.system("${zenhan} 0")
--       end,
--     })
--   end
-- end
