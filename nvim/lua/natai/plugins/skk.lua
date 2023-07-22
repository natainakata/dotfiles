local utils = require("natai.utils")
return {
  {
    "vim-skk/skkeleton",
    lazy = false,
    dependencies = "vim-denops/denops.vim",
    init = function()
      utils.imap("<C-j>", "<Plug>(skkeleton-toggle)")
      utils.cmap("<C-j>", "<Plug>(skkeleton-toggle)")
      local dictionaries = {}
      local handle = io.popen("ls $HOME/.skk/*")
      if handle then
        for file in handle:lines() do
          table.insert(dictionaries, file)
        end
        handle:close()
      end

      vim.api.nvim_create_autocmd("User", {
        group = utils.augroup("skkeleton"),
        pattern = "skkeleton-initialize-pre",
        callback = function()
          vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            registerConvertResult = true,
            globalDictionaries = dictionaries,
          })
        end,
      })
    end,
  },
}
