local keymap = vim.keymap

keymap.set("", "<Space>", "<Nop>")
local opts = { silent = true }

-- general keymap
keymap.set("n", "j", "gj")
keymap.set("n", "gj", "j")
keymap.set("n", "k", "gk")
keymap.set("n", "gk", "k")
keymap.set("n", "U", "<C-r>")
-- keymap.set("n", "<Leader>w", ":w<CR>", opts)
-- keymap.set({ "n", "i", "v", "s" }, "<C-s>", ":w<CR><Esc>", opts)
keymap.set("i", "jj", "<Esc>")
keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)
keymap.set("n", "<Leader>q", "<Cmd>qa<cr>", opts)
keymap.set("n", "x", [["_x]], opts)

-- window and buffer
--
keymap.set("n", "<S-Tab>", "<Cmd>bprevious<CR>")
keymap.set("n", "<Tab>", "<Cmd>bnext<CR>")
keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>")
keymap.set("n", "<S-l>", "<Cmd>bnext<CR>")

keymap.set("n", "gs", "<Cmd>split<CR><C-w>w", opts)
keymap.set("n", "gv", "<Cmd>vsplit<CR><C-w>w", opts)

keymap.set("n", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", opts)
keymap.set("n", "<Leader><Tab>h", "<Cmd>tabprevious<CR>", opts)
keymap.set("n", "<Leader><Tab>l", "<Cmd>tabnext<CR>", opts)
keymap.set("n", "<Leader><Tab>q", "<Cmd>tabclose<CR>", opts)

keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { remap = true })
keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { remap = true })
keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { remap = true })
keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { remap = true })

keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

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

keymap.set("n", "<Leader>D", ":BufferDeleteSafety<CR>", opts)

-- fold
keymap.set("n", "Z", ":set foldmethod=indent<CR>", opts)

-- terminal
keymap.set("n", "<Leader>t", "<Cmd>terminal<CR>", opts)
keymap.set("n", "<Leader>T", "<Cmd>belowright new<CR><Cmd>terminal<CR>", opts)
keymap.set("t", "JJ", "<C-\\><C-n>", opts)
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- lazy
keymap.set("n", "<Leader>lz", "<Cmd>Lazy<CR>", { silent = true })
