local keymap = vim.keymap

keymap.set("", "<Space>", "<Nop>")
local opts = { silent = true }

-- general keymap
keymap.set("n", "j", "gj")
keymap.set("n", "gj", "j")
keymap.set("n", "k", "gk")
keymap.set("n", "gk", "k")
keymap.set("n", "U", "<C-r>")
keymap.set("n", "<Leader>w", ":w<CR>", opts)
keymap.set({ "n", "i", "v", "s" }, "<C-s>", ":w<CR><Esc>", opts)
keymap.set("i", "jj", "<Esc>")
keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)
keymap.set("n", "<Leader>qq", "<Cmd>qa<cr>", opts)

-- window and buffer
--
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")
keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>")
keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>")
keymap.set("n", "gs", "<Cmd>split<CR><C-w>w", opts)
keymap.set("n", "gv", "<Cmd>vsplit<CR><C-w>w", opts)

keymap.set("n", "<leader><Tab><Tab>", "<Cmd>tabnew<CR>", opts)
keymap.set("n", "<leader><Tab>h", "<Cmd>tabprevious<CR>", opts)
keymap.set("n", "<leader><Tab>l", "<Cmd>tabnext<CR>", opts)
keymap.set("n", "<leader><Tab>q", "<Cmd>tabclose<CR>", opts)

keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { remap = true })
keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { remap = true })
keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { remap = true })
keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { remap = true })

keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { remap = true })
keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { remap = true })
keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { remap = true })
keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { remap = true })

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
keymap.set("t", "<Esc>", [[<C-\><C-n>]])
