return {
	"vim-skk/skkeleton",
	commit = "b530eac5a859ce2f8fa4d99fa5cd83b9d3199086",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc.vim",
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

		vim.fn["ddc#custom#patch_global"]({
			ui = "pum",
			sources = {},
			sourceOptions = {
				skkeleton = {
					mark = "skkeleton",
					matchers = {},
					sorters = {},
					converters = {},
					isVolatile = true,
					minAutoCompleteLength = 1,
				},
			},
			autoCompleteEvents = {
				"InsertEnter",
				"TextChangedI",
				"TextChangedP",
			},
		})

		vim.fn["ddc#enable"]()

		local prev_buffer_config

		vim.api.nvim_create_autocmd("User", {
			pattern = "skkeleton-enable-pre",
			callback = function()
				prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
				vim.fn["ddc#custom#patch_buffer"]("sources", { "skkeleton" })
				vim.b.skkeleton_active = true
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "skkeleton-disable-pre",
			callback = function()
				vim.fn["ddc#custom#set_buffer"](prev_buffer_config)
				vim.b.skkeleton_active = false
			end,
		})
	end,
}
