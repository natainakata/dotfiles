local utils = require("rc.utils")
local nmap = utils.nmap
local imap = utils.imap
local xmap = utils.xmap
local tmap = utils.tmap

vim.keymap.set("", "<Space>", "<Nop>")
local opts = { silent = true }

-- general keymap
nmap("j", "gj")
nmap("gj", "j")
nmap("k", "gk")
nmap("gk", "k")
nmap("U", "<C-r>")
imap("jj", "<Esc>")
nmap("<Esc><Esc>", ":nohlsearch<CR>")
nmap("<Leader>q", "<Cmd>qa<cr>")
nmap("x", [["_x]])

-- window and buffer
--
nmap("<S-Tab>", "<Cmd>bprevious<CR>")
nmap("<Tab>", "<Cmd>bnext<CR>")
nmap("<S-h>", "<Cmd>bprevious<CR>")
nmap("<S-l>", "<Cmd>bnext<CR>")
nmap("gs", "<Cmd>split<CR><C-w>w", opts)
nmap("gv", "<Cmd>vsplit<CR><C-w>w", opts)

nmap("<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", opts)
nmap("<Leader><Tab>h", "<Cmd>tabprevious<CR>", opts)
nmap("<Leader><Tab>l", "<Cmd>tabnext<CR>", opts)
nmap("<Leader><Tab>q", "<Cmd>tabclose<CR>", opts)

nmap("<C-h>", "<Cmd>wincmd h<CR>", { remap = true })
nmap("<C-j>", "<Cmd>wincmd j<CR>", { remap = true })
nmap("<C-k>", "<Cmd>wincmd k<CR>", { remap = true })
nmap("<C-l>", "<Cmd>wincmd l<CR>", { remap = true })
nmap("<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
nmap("<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
nmap("<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
nmap("<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

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

-- fold
nmap("Z", ":set foldmethod=indent<CR>")

-- terminal
nmap("<Leader>t", "<Cmd>terminal<CR>")
nmap("<Leader>T", "<Cmd>belowright new<CR><Cmd>terminal<CR>")
tmap("JJ", "<C-\\><C-n>")
tmap("<Esc><Esc>", "<C-\\><C-n>")

-- lazy
nmap("<Leader>lz", "<Cmd>Lazy<CR>")
