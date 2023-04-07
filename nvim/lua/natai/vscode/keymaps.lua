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


keymap.set("n", "<S-Tab>", function() vim.fn['VSCodeNotify']('workbench.action.previousEditor') end, opts)
keymap.set("n", "<Tab>", function() vim.fn['VSCodeNotify']('workbench.action.nextEditor') end, opts)
keymap.set("n", "<S-h>", function() vim.fn['VSCodeNotify']('workbench.action.previousEditor') end, opts)
keymap.set("n", "<S-l>", function() vim.fn['VSCodeNotify']('workbench.action.nextEditor') end, opts)
keymap.set("n", "gs", function() vim.fn['VSCodeNotify']('workbench.action.splitEditor') end, opts)
keymap.set("n", "gv", function() vim.fn['VSCodeNotify']('workbench.action.splitEditorOrthogonal') end, opts)

keymap.set("n", "<Leader>f", function() vim.fn['VSCodeNotify']('workbench.action.quickOpen') end, opts)
keymap.set("n", "<Leader>p", function() vim.fn['VSCodeNotify']('workbench.action.showCommands') end, opts)
keymap.set("n", "<Leader>E", function() vim.fn['VSCodeNotify']('workbench.view.explorer') end, opts)
