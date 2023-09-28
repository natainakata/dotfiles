local utils = require("rc.utils")
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

autocmd({ "BufNewFile", "BufRead" }, {
  group = utils.augroup("ime"),
  pattern = "*.ime",
  command = "set filetype=ime",
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
autocmd("FileType", {
  group = utils.augroup("ime_settings"),
  pattern = {
    "ime",
  },
  callback = function()
    require("notify").dismiss({ silent = true, pending = true })
    utils.nmap("q", "<Cmd>wq!<CR>")
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
      vertical resize 70
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
