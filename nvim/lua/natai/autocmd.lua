local function augroup(name)
  return vim.api.nvim_create_augroup("natai_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  group = augroup("term_insert_in"),
  callback = function()
    vim.opt_local.number = false
    vim.cmd.startinsert()
  end,
})

autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd("CmdwinEnter", {
  group = augroup("cmdwinclose"),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("mclang"),
  pattern = "*.lang",
  command = "set filetype=mclang",
})

if vim.fn.executable("zenhan") then
  autocmd({"InsertLeave", "CmdlineLeave"}, {
    group = augroup("disable_ime"),
    callback = function ()
      os.execute("zenhan 0")
    end
  })
end

