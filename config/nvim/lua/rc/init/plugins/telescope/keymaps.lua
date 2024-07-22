local M = {}
M.core = {
  {
    "<C-f>",
    function()
      require("telescope.builtin").find_files({
        no_ignore = false,
        hidden = false,
      })
    end,
    desc = "Find File",
  },
  {
    "<Leader>p",
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Find Keymaps",
  },
  {
    "<Leader>P",
    function()
      require("telescope.builtin").commands()
    end,
    desc = "Find Commands",
  },
  {
    "<Leader>f",
    function()
      require("telescope.builtin").find_files({
        no_ignore = true,
        hidden = true,
      })
    end,
    desc = "Find File (ALL)",
  },
  {
    "<Leader>/",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "live grep",
  },
  {
    "<Leader>b",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffer List",
  },
  {
    "<Leader>?",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Neovim Documents",
  },
  {
    "<Leader>R",
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Recent Files",
  },
  {
    "<Leader>gs",
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Git Status",
  },
  {
    "<Leader>gb",
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Git Branches",
  },
}
M.file_browser = {
  {
    "<Leader>F",
    function()
      require("telescope").extensions.file_browser.file_browser({
        path = vim.fn.getcwd(),
        cwd = vim.fn.getcwd(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 0.5 },
      })
    end,
    desc = "File Browser",
  },
}
M.frecency = {
  {
    "<Leader>r",
    function()
      require("telescope").extensions.frecency.frecency()
    end,
    desc = "File Frecency",
  },
}
M.symbols = {
  {
    "<C-f>",
    function()
      require("telescope.builtin").symbols()
    end,
    desc = "Symbols",
    mode = "i",
  },
}

return M
