return {
	"stevearc/conform.nvim",
	version = "v9.1.0",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- 対応言語は導入済みのLSPサーバに合わせて設定
		--pyright/texlab/marksmanにはフォーマット機能がないためconformで代替
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			c = { "clang-format" },
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- formatters_by_ftに未定義のftはLSPのフォーマット機能にフォールバック
		},
	},
}
