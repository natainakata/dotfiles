local indent = 2
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = ","

opt.fenc = "utf-8"
opt.backup = false
opt.swapfile = false

opt.expandtab = true
opt.smartindent = true
opt.tabstop = indent
opt.shiftwidth = indent

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = true

opt.virtualedit = "onemore"
opt.clipboard:append({ "unnamed", "unnamedplus" })

opt.list = true

opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.visualbell = true
opt.wildmode = { "list", "longest" }
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3
opt.showtabline = 2
opt.cmdwinheight = 10
opt.cmdheight = 0

opt.listchars:append("eol:↴")
opt.showmatch = true
opt.cursorcolumn = true
opt.signcolumn = "yes"
opt.guifont = { "UDEV Gothic 35NFLG:h14:n" }
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

if vim.loop.os_uname().sysname == "Linux" then
  if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ["+"] = "/mnt/c/bin/win32yank.exe -i",
        ["*"] = "/mnt/c/bin/win32yank.exe -i",
      },
      paste = {
        ["+"] = "/mnt/c/bin/win32yank.exe -o",
        ["*"] = "/mnt/c/bin/win32yank.exe -o",
      },
      cache_enabled = 1,
    }
  end
else
  vim.g.sqlite_clib_path = "C:/lib/sqlite3.dll"
  vim.o.shell = "pwsh.exe"
  vim.o.shellcmdflag = "-NoLogo -c"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
  opt.completeslash = "slash"
end
for name, icon in pairs(require("rc.utils.icons").diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
