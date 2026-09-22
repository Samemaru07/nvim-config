-- GitHubのIssue・PRをNeovim内で操作するツール
return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Octo",
	keys = {
		{ "<leader>gp", "<cmd>Octo pr list<cr>", desc = "Octo PR List" },
	},
	opts = {},
	config = function(_, opts)
		require("octo").setup(opts)

		-- octo バッファの設定（クラッシュ防止 & プレースホルダー移動）
		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			pattern = { "octo", "octo_panel" },
			callback = function(args)
				-- 破棄時のコア Segfault を防止
				vim.bo[args.buf].undolevels = -1

				-- PRテンプレート内のタブジャンプ
				vim.keymap.set("n", "<Tab>", function()
					if vim.fn.search("<++>") ~= 0 then
						local feed = vim.api.nvim_replace_termcodes("cf>", true, false, true)
						vim.api.nvim_feedkeys(feed, "m", false)
					end
				end, { buffer = args.buf, silent = true, desc = "Jump to next placeholder" })
			end,
		})
	end,
}
