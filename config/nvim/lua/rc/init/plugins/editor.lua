local icons = require("rc.utils.icons")

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    enabled = is_nvim(),
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeOpen" },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
    },
    opts = {
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
    enabled = is_nvim(),
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    cmd = { "Oil" },
    keys = { { "<Leader>O", "<Cmd>Oil<CR>", desc = "Open Oil" } },
    config = true,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    enabled = is_nvim(),
    keys = {
      { "<Leader>o", "<cmd>SymbolsOutline<CR>", desc = "Outline List" },
    },
    opts = {
      symbols = {
        File = { icon = icons.kinds.File, hl = "@text.uri" },
        Module = { icon = icons.kinds.Module, hl = "@namespace" },
        Namespace = { icon = icons.kinds.Namespace, hl = "@namespace" },
        Package = { icon = icons.kinds.Package, hl = "@namespace" },
        Class = { icon = icons.kinds.Class, hl = "@type" },
        Method = { icon = icons.kinds.Method, hl = "@method" },
        Property = { icon = icons.kinds.Property, hl = "@method" },
        Field = { icon = icons.kinds.Field, hl = "@field" },
        Constructor = { icon = icons.kinds.Constructor, hl = "@constructor" },
        Enum = { icon = icons.kinds.Enum, hl = "@type" },
        Interface = { icon = icons.kinds.Interface, hl = "@type" },
        Function = { icon = icons.kinds.Function, hl = "@function" },
        Variable = { icon = icons.kinds.Variable, hl = "@constant" },
        Constant = { icon = icons.kinds.Constant, hl = "@constant" },
        String = { icon = icons.kinds.String, hl = "@string" },
        Number = { icon = icons.kinds.Number, hl = "@number" },
        Boolean = { icon = icons.kinds.Boolean, hl = "@boolean" },
        Array = { icon = icons.kinds.Array, hl = "@constant" },
        Object = { icon = icons.kinds.Object, hl = "@type" },
        Key = { icon = icons.kinds.Key, hl = "@type" },
        Null = { icon = icons.kinds.Null, hl = "@type" },
        EnumMember = { icon = icons.kinds.EnumMember, hl = "@field" },
        Struct = { icon = icons.kinds.Struct, hl = "@type" },
        Event = { icon = icons.kinds.Event, hl = "@type" },
        Operator = { icon = icons.kinds.Operator, hl = "@operator" },
        TypeParameter = { icon = icons.kinds.TypeParameter, hl = "@parameter" },
        Component = { icon = icons.kinds.Function, hl = "@function" },
        Fragment = { icon = icons.kinds.Constant, hl = "@constant" },
      },
    },
  },
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "<Leader>h", ":<C-u>HopWord<CR>",      silent = true, desc = "Hop Word" },
      { "<Leader>H", ":<C-u>HopPattern<CR>",   silent = true, desc = "Hop Pattern" },
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
    enabled = is_nvim(),
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
    "lambdalisue/gin.vim",
    enabled = is_nvim(),
    dependencies = "vim-denops/denops.vim",
    lazy = false,
  },
  {
    "thinca/vim-quickrun",
    dependencies = "lambdalisue/vim-quickrun-neovim-job",
    cmd = "QuickRun",
    keys = {
      { mode = { "n" }, "gx", require("rc.utils").operator("quickrun#operator"), { expr = true, silent = true } },
      { mode = { "v" }, "gx", ":QuickRun -mode v<CR>",                           { silent = true } },
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
    config = function(_, opts)
      vim.g.quickrun_config = opts
    end,
  },
}
