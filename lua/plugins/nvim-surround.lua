-- 選択範囲・モーションを括弧/クォート/タグ等で「囲む/変える/消す」
return {
	"kylechui/nvim-surround",
	version = "^4.0.0",
	event = "VeryLazy",
	init = function()
		vim.g.nvim_surround_no_insert_mappings = true
	end,
}
