-- 画面上部にカレントバッファのパス階層をパンくず表示する
return {
	"Bekaboo/dropbar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	config = function()
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick Symbol in Winbar" })
	end,
}
