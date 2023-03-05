return {
  { "folke/lazy.nvim", version = "*" },
  -- runtime
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "yuki-yano/denops-lazy.nvim", lazy = true },
  { "vim-jp/vimdoc-ja" },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 5
    end,
  },
}
