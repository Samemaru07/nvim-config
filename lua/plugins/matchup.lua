return {
	"andymass/vim-matchup",
	event = "VeryLazy",
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.keymap.del("i", "<C-g>%")
	end,
}
