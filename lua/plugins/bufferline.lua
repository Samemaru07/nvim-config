-- 画面丈夫のバッファ一覧タブ．
return {
	"akinsho/bufferline.nvim", -- タグ付けされた最新のものを追う(指定していないと，mainの最新コミット)
	version = "*",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
}
