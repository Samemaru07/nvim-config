return {
	"GCBallesteros/NotebookNavigator.nvim",
	ft = { "python" },
	dependencies = {
		"echasnovski/mini.comment",
	},
	keys = {
		{
			"]h",
			function()
				require("notebook-navigator").move_cell("d")
			end,
			desc = "次のセルへ移動",
		},
		{
			"[h",
			function()
				require("notebook-navigator").move_cell("u")
			end,
			desc = "前のセルへ移動",
		},
		{
			"<localleader>mc",
			function()
				require("notebook-navigator").run_cell()
			end,
			desc = "現在のセルを実行",
		},
		{
			"<localleader>mC",
			function()
				require("notebook-navigator").run_and_move()
			end,
			desc = "現在のセルを実行し次のセルへ移動",
		},
	},
	opts = {
		repl_provider = "molten",
	},
}
