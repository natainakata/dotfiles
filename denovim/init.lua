local denops = vim.fn.expand("~/.cache/denovim/dvpm/github.com/vim-denops/denops.vim")
if not vim.loop.fs_stat(denops) then
	vim.fn.system({ "git", "clone", "https://github.com/vim-denops/denops.vim", denops })
end
vim.opt.runtimepath:prepend(denops)
