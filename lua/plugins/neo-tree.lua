-- ツリー形式nのファイラ
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true, -- .gitignore対象の隠しファイルも表示する
			},
		},
		window = {
			width = 30,
		},
	},
}
