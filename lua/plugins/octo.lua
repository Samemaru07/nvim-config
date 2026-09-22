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

				-- 検索レジスタを <++> に設定
				local function jump_placeholder()
					if vim.fn.search("<++>", "W") ~= 0 then
						-- 検索レジスタ @/ を直接更新して cgn で削除・インサートへ移行
						vim.fn.setreg("/", "<++>")
						local feed = vim.api.nvim_replace_termcodes("cgn", true, false, true)
						vim.api.nvim_feedkeys(feed, "n", false)
						return true
					end
					return false
				end

				-- ノーマルモード
				vim.keymap.set("n", "<Tab>", function()
					jump_placeholder()
				end, { buffer = args.buf, silent = true, desc = "Jump to next placeholder" })

				-- インサートモード（補完メニュー非表示時のみジャンプ）
				vim.keymap.set("i", "<Tab>", function()
					if vim.fn.pumvisible() == 0 and vim.fn.search("<++>", "nW") ~= 0 then
						local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
						vim.api.nvim_feedkeys(esc, "n", false)
						vim.schedule(jump_placeholder)
						return
					end

					local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
					vim.api.nvim_feedkeys(tab, "n", false)
				end, { buffer = args.buf, silent = true, desc = "Jump to next placeholder (insert)" })
			end,
		})
	end,
}
