local utils = require("rc.utils")
local helper = require("rc.utils.ddu")

local spec = {
  "Shougo/ddu-ui-ff",
  lazy = false,
  dependencies = "ddu.vim",
  config = function()
    helper.patch_global({
      ui = "ff",
      uiParams = {
        ff = {
          startFilter = false,
          prompt = "> ",
          autoAction = {
            name = "preview",
          },
          startAutoAction = true,
          previewSplit = "vertical",
          previewFloating = true,
          split = "floating",
          filterSplitDirection = "floating",
          filterFloatingPosition = "top",
          floatingBorder = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          previewFloatingBorder = "single",
        },
      },
    })
    helper.ff_map(nil, function(map)
      -- Enter filter
      map("i", helper.action("openFilterWindow"))
      -- Close UI
      map("<Esc>", helper.action("quit"))
      map("q", helper.action("quit"))
      -- Toggle selected state for all items
      map("a", helper.action("toggleAllItems"))
      -- Toggle selected state for cursor item
      map(" ", helper.action("toggleSelectItem"))
      -- Expand item tree
      map("e", helper.action("expandItem", { mode = "toggle" }))
      -- Show available actions
      map("+", helper.action("chooseAction"))
      -- Toggle preview
      map("p", helper.action("toggleAutoAction"))
      -- Default itemAction
      map("<CR>", helper.item_action("default"))
    end)

    helper.ff_filter_map(nil, function(map)
      -- Close UI
      map("i", "jj", helper.action("closeFilterWindow", nil, true))
      map({ "n", "i" }, "<CR>", helper.item_action("default"))
      -- Close filter window
      map({ "n", "i" }, "<Esc>", helper.action("closeFilterWindow", nil, true))
      map("n", "j", helper.action("closeFilterWindow", nil, true))
    end)
    local function resize()
      local lines = vim.opt.lines:get()
      local height, row = math.floor(lines * 0.8), math.floor(lines * 0.1)
      local columns = vim.opt.columns:get()
      local width, col = math.floor(columns * 0.8), math.floor(columns * 0.1)
      local previewWidth = math.floor(width / 2)

      helper.patch_global({
        uiParams = {
          ff = {
            winHeight = height,
            winRow = row,
            winWidth = width,
            winCol = col,
            previewHeight = height,
            previewRow = row,
            previewWidth = previewWidth,
            previewCol = col + (width - previewWidth),
          },
        },
      })
    end
    resize()

    utils.autocmd("resize_ddu_ff", "VimResized", nil, resize)
  end,
}

return spec
