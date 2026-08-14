-- キー入力の途中でキーバインド一覧をポップアップ表示する．
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function() -- rtpに乗る前に利用できるようにする．(全てnvimデフォルトのオプション)
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {},
}
