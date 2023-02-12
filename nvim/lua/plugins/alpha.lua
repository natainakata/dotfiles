local status, alpha = pcall(require, "alpha")
if (not status) then return end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", "<cmd>ene<CR>"),
  dashboard.button("e", "  Browze Directory", "<cmd>Neotree<CR>"),
  dashboard.button("f", "  Find file", "<cmd>lua require('telescope.builtin').find_files({no_ignore = true, hidden = true})<CR>"),
  dashboard.button("q", "  Quit NVIM" , "<cmd>qa<CR>"),
}
alpha.setup(dashboard.config)

