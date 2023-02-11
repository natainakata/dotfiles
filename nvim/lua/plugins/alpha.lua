local status, alpha = pcall(require, "alpha")
if (not status) then return end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("e", "  Browze Directory", ":Neotree<CR>"),
  dashboard.button("f", "  Find file", ":lua function() require('telescope.builtin').find_files({no_ignore = true, hidden = true}) end"),
  dashboard.button("q", "  Quit NVIM" , ":qa<CR>"),
}
alpha.setup(dashboard.config)

