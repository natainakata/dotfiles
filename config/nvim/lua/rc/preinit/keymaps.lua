local utils = require("rc.utils")
local nmap = utils.nmap
local imap = utils.imap
local xmap = utils.xmap
local tmap = utils.tmap
local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- general keymap
nmap("j", "gj")
nmap("gj", "j")
nmap("k", "gk")
nmap("gk", "k")
nmap("U", "<C-r>")
imap("jj", "<Esc>")
nmap("<Esc><Esc>", ":nohlsearch<CR>")
nmap("<Leader>q", "<Cmd>qa<CR>")

-- register
for _, key in ipairs({ "x", "X" }) do
  keymap.set({ "n", "x" }, key, [["_]] .. key, { desc = key .. " with blackhole register" })
end

-- text objects
for _, quote in ipairs({ '"', "'", "`" }) do
  keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-- window control

-- quit
nmap("zq", "<Cmd>q<CR>")

-- buffer
nmap("<S-Tab>", "<Cmd>bprevious<CR>")
nmap("<Tab>", "<Cmd>bnext<CR>")
nmap("<S-h>", "<Cmd>bprevious<CR>")
nmap("<S-l>", "<Cmd>bnext<CR>")

-- window
for _, key in ipairs({ "h", "j", "k", "l" }) do
  nmap("<C-" .. key .. ">", "<Cmd>wincmd " .. key .. "<CR>", { remap = true })
end

-- kill buffer
vim.api.nvim_create_user_command("BufferDeleteSafety", function()
  if vim.fn.input("delete buffer? (y/N): ") == "y" then
    vim.cmd([[
        redraw
        bdelete!
      ]])
    print("delete buffer!")
  end
end, { nargs = 0 })

nmap("<Leader>D", ":BufferDeleteSafety<CR>")

tmap("JJ", "<C-\\><C-n>")
tmap("<Esc><Esc>", "<C-\\><C-n>")
