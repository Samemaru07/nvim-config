return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		-- LSPサーバ以外のフォーマッタ・リンタのMason経由での自動インストール
		ensure_installed = {
			"stylua", -- conform.nvim: lua
			"black", -- conform.nvim: python
			"prettier", -- conform.nvim: html/css/js/ts/markdown
			"shfmt", -- conform.nvim: sh
			"shellcheck", -- nvim-lint: sh
		},
	},
}
