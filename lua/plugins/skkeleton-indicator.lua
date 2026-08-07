return {
	"delphinus/skkeleton_indicator.nvim",
	dependencies = { "vim-skk/skkeleton" },
	opts = {
		eijiText = "英数",
		hiraText = "かな",
		kataText = "カナ",
		hankanaText = "半ｶﾅ",
	},
	config = function(_, opts)
		require("skkeleton_indicator").setup(opts)

		local function set_skkeleton_indicator_highlights()
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji", { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata", { fg = "#1e1e2e", bg = "#f9e2af", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorHankata", { fg = "#1e1e2e", bg = "#cba6f7", bold = true })
		end

		set_skkeleton_indicator_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_skkeleton_indicator_highlights,
		})
	end,
}
