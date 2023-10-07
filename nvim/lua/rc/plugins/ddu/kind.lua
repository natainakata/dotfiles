local helper = require("rc.utils.ddu")

local spec = {
  {
    "Shougo/ddu-kind-file",
    lazy = false,
    dependencies = "ddu.vim",
    opts = {
      kindOptions = {
        file = {
          defaultAction = "open",
        },
      },
    },
    init = function()
      helper.ff_map("file", function(map)
        -- Open file
        map("<C-x>", helper.item_action("open", { command = "split" }))
        map("<C-v>", helper.item_action("open", { command = "vsplit" }))
        -- map("<C-t>", helper.item_action("openProject"))
        -- Send quickfix
        map("q", helper.item_action("quickfix"))
      end)

      helper.ff_filter_map("file", function(map)
        -- Open file
        map("i", "<C-x>", helper.item_action("open", { command = "split" }, true))
        map("i", "<C-v>", helper.item_action("open", { command = "vsplit" }, true))
        -- map("i", "<C-t>", helper.item_action("openProject", nil, true))
      end)
    end,
    config = function(_, opts)
      helper.patch_global(opts)
    end,
  },
  {
    "Shougo/ddu-kind-word",
    lazy = false,
    dependencies = "ddu.vim",
    opts = {
      kindOptions = {
        word = {
          defaultAction = "append",
        },
      },
    },
    config = function(_, opts)
      helper.patch_global(opts)
    end,
  },
}

return spec
