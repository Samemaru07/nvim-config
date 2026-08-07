return {
	"vim-skk/skkeleton",
	commit = "b530eac5a859ce2f8fa4d99fa5cd83b9d3199086",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
	},
	config = function()
		vim.fn["skkeleton#config"]({
			globalDictionaries = { "~/.skk/SKK-JISYO.L" },
			userDictionary = "~/.skkeleton",
			completionRankFile = "~/.skk/rank.json",
			eggLikeNewline = true,
			markerHenkan = "▼",
			markerHenkanSelect = "▼",
		})
	end,
}
