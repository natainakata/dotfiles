local function reloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^natainakata') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.keymap.set('n', '<Leader>R', function() reloadConfig() end)
