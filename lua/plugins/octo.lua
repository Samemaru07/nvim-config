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
		{ "<leader>gp", "<cmd>Oct pr list<cr>", desc = "Octo PR List" },
	},
	opts = {},
	config = function(_, opts)
		require("octo").setup(opts)

		-- PRテンプレート内のタブジャンプ
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "octo",
			callback = function(args)
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
