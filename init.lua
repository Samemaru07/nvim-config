-- Leader Key (プラグインマネージャ導入時にも影響するため，requireよりも前に設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- lazy.nvimのインストール確認・未インストール時は自動clone
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "lazy.nvimのcloneに失敗しました:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\n何かキーを押すと終了します" },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "kanagawa" } },
	checker = { enabled = false },
	rocks = { enabled = false },
})
