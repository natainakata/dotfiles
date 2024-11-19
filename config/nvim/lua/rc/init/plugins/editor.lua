local icons = require("rc.utils.icons")

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeOpen" },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
    },
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "s", { buffer = bufnr })
        vim.keymap.set("n", "<C-o>", api.node.run.system, opts("Run System"))
      end,
      disable_netrw = false,
      hijack_netrw = false,
      filters = {
        dotfiles = true,
        git_ignored = false,
      },
      renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = icons.files.modified,
              staged = icons.git.staged,
              unmerged = icons.git.merged,
              renamed = icons.git.renamed,
              untracked = icons.git.added,
              deleted = icons.git.removed,
              ignored = icons.git.ignored,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.api.nvim_create_autocmd({ "QuitPre" }, {
        callback = function()
          vim.cmd("NvimTreeClose")
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    cmd = { "Oil" },
    keys = { { "<Leader>O", "<Cmd>Oil<CR>", desc = "Open Oil" } },
    config = true,
  },

  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "<Leader>h", ":<C-u>HopWord<CR>", silent = true, desc = "Hop Word" },
      { "<Leader>H", ":<C-u>HopPattern<CR>", silent = true, desc = "Hop Pattern" },
      { "<Leader>L", ":<C-u>HopLineStart<CR>", silent = true, desc = "Hop Line" },
    },
  },
  {
    "echasnovski/mini.jump",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "kevinhwang91/nvim-bqf",
    config = true,
    ft = "qf",
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },
  {
    "tkmpypy/chowcho.nvim",
    event = "VeryLazy",
    config = function()
      local chowcho = require("chowcho")
      chowcho.setup({})
      local win_keymap_set = function(key, callback)
        vim.keymap.set({ "n", "t" }, "<C-w>" .. key, callback)
        vim.keymap.set({ "n", "t" }, "<C-w><C-" .. key .. ">", callback)
      end

      win_keymap_set("w", function()
        local wins = 0

        for i = 1, vim.fn.winnr("$") do
          local win_id = vim.fn.win_getid(i)
          local conf = vim.api.nvim_win_get_config(win_id)

          if conf.focusable then
            wins = wins + 1

            if wins > 2 then
              chowcho.run()
              return
            end
          end
        end

        vim.api.nvim_command("wincmd w")
      end)
    end,
  },
  {
    "lambdalisue/gin.vim",
    dependencies = "vim-denops/denops.vim",
    lazy = false,
    version = false,
    keys = {
      -- git prefix <Leader>g
      {
        "<Leader>gd",
        function()
          vim.cmd([[GinDiff ++processor=delta\ --no-gitconfig\ --color-only]])
        end,
        desc = "Git Diff",
        silent = true,
      },
      {
        "<Leader>gc",
        function()
          vim.cmd([[Gin commit]])
        end,
        desc = "Git Commit",
        silent = true,
      },
      {
        "<Leader>gl",
        function()
          vim.cmd([[GinLog]])
        end,
        desc = "Git Commit Log",
        silent = true,
      },
    },
  },
  {
    "thinca/vim-quickrun",
    dependencies = "lambdalisue/vim-quickrun-neovim-job",
    cmd = "QuickRun",
    keys = {
      { mode = { "n" }, "gx", require("rc.utils").operator("quickrun#operator"), { expr = true, silent = true } },
      { mode = { "v" }, "gx", ":QuickRun -mode v<CR>", { silent = true } },
    },
    opts = {
      ["_"] = {
        outputter = "error",
        ["outputter/error/success"] = "buffer",
        ["outputter/error/error"] = "quickfix",
        ["outputter/buffer/opener"] = "new",
        ["outputter/buffer/into"] = 1,
        ["outputter/buffer/close_on_empty"] = 1,
        ["runner"] = "neovim_job",
      },
    },
    init = function(_, opts)
      vim.g.quickrun_config = opts
    end,
  },
  {
    "Allianaab2m/vimskey",
    dependencies = "vim-denops/denops.vim",
    lazy = false,
  },
}
