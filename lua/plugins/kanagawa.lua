return {
	"rebelot/kanagawa.nvim",
	lazy = false, -- 起動時に即読み込み
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("kanagawa")
	end,
}
