local icons = require("natai.icons")
local is_nvim = require("natai.util").is_vscode
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeOpen" },
    enabled = is_nvim,
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      filters = {
        dotfiles = true,
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
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
        pattern = "NvimTree_*",
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if
            layout[1] == "leaf"
            and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
            and layout[3] == nil
          then
            vim.cmd("confirm quit")
          end
        end,
      })
    end,
  },
  {
    "hkupty/iron.nvim",
    enabled = is_nvim,
    keys = {
      { "<Leader>Is", "<cmd>IronRepl<cr>", desc = "IronRepl" },
      { "<Leader>Ir", "<cmd>IronRestart<cr>", desc = "IronRestart" },
      { "<Leader>If", "<cmd>IronFocus<cr>", desc = "IronFocus" },
      { "<Leader>Ih", "<cmd>IronHide<cr>", desc = "IronHide" },
    },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = view.split("40%"),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    enabled = is_nvim,
    cmd = "SymbolsOutline",
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
      { "<Leader>h", ":<C-u>HopWord<CR>", silent = true, desc = "Hop Word" },
      { "<Leader>H", ":<C-u>HopPattern<CR>", silent = true, desc = "Hop Pattern" },
      { "<Leader>L", ":<C-u>HopLineStart<CR>", silent = true, desc = "Hop Line" },
    },
  },
  {
    "echasnovski/mini.jump",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
      --vim.api.nvim_create_autocmd("FileType", {
      --  callback = function()
      --    local buffer = vim.api.nvim_get_current_buf()
      --    pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
      --    pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
      --  end,
      --})
    end,
    -- stylua: ignore
    -- keys = {
    --   { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
    --   { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    -- },
  },
}
