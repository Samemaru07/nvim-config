return {
	"j-hui/fidget.nvim",
	event = "LspAttach", -- LSPサーバがバッファにアタッチした瞬間に読み込む
	opts = {
		progress = {
			ignore = { "pyright" },
		},
	},
}
