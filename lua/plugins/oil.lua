-- ディレクトリをバッファとして編集できるファイラ (ファイル作成・リネーム・削除向け)
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>o",
			function()
				require("oil").open_float(nil, { preview = {} })
			end,
			desc = "Open Parent Directory (Oil Float)",
		},
	},
	opts = {
		view_options = {
			show_hidden = true,
		},
		float = {
			padding = 2,
			max_width = 90,
			max_height = 30,
		},
		keymaps = {
			["q"] = "actions.close",
			["<C-s>"] = "<cmd>:w<cr>",
		},
	},
}
