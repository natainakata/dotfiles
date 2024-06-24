local utils = require("rc.utils")
return {
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescript",
    "typescriptreact",
    "vue",
  },
  on_attach = function(client, buffer)
    utils.imap("<C-x>", function()
      vim.cmd.stopinsert()
      client.request("textDocument/completion", vim.lsp.util.make_position_params(), function(_, result)
        local textEdit = result[1].textEdit
        local snip_string = textEdit.newText
        textEdit.newText = ""
        vim.lsp.util.apply_text_edits({ textEdit }, buffer, client.offset_encoding)
        require("luasnip").lsp_expand(snip_string)
      end, buffer)
    end, { buffer = buffer, noremap = true })
  end,
}
