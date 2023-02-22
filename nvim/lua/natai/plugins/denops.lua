local status, denops = pcall(require, "denops-lazy")
if not status then
  return
end

return {
  { "vim-denops/denops.vim", event = "VeryLazy" },
  {
    "lambdalisue/gin.vim",
    dependencies = "vim-denops/denops.vim",
    event = "VeryLazy",
    keys = {
      { "<C-g>c", "<Cmd>Gin ++wait add . | Gin commit<CR>", desc = "Git Commit" },
    },
    config = function()
      denops.load("gin.vim", {})
    end,
  },
}
