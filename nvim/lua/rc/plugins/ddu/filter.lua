local helper = require("rc.utils.ddu")
local spec = {
  {
    "Shougo/ddu-filter-matcher_substring",
    lazy = false,
    dependencies = "ddu.vim",
    opts = {
      sourceOptions = {
        ["_"] = {
          matchers = {
            "matcher_substring",
          },
        },
      },
      filterOptions = {
        matcher_substring = {
          highlightMatched = "Title",
        },
      },
    },
    config = function(_, opts)
      helper.patch_global(opts)
    end,
  },
  {
    "uga-rosa/ddu-filter-converter_devicon",
    lazy = false,
    dependencies = "ddu.vim",
  },
}

return spec
