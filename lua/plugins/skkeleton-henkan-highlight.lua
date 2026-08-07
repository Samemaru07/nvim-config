return {
	"NI57721/skkeleton-henkan-highlight",
	dependencies = {
		"vim-skk/skkeleton",
	},
	config = function()
		vim.api.nvim_set_hl(0, "SkkeletonHenkan", { fg = "#1e1e2e", bg = "#f9e2af" })
		vim.api.nvim_set_hl(0, "SkkeletonHenkanSelect", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
	end,
}
