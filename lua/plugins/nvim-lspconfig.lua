return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	-- 全てのLSPサーバに共通適用
	vim.lsp.config("*", {
		capabilities = capabilities,
	})
	end,
}
