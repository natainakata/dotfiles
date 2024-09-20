local indent = 2
local opt = vim.opt
local icons = require("rc.utils.icons")

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

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.sqlite_clib_path = "C:/lib/sqlite3.dll"
  vim.o.shell = "pwsh.exe"
  vim.o.shellcmdflag = "-NoLogo -c"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
  opt.completeslash = "slash"
end

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
    },
  },
})

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
