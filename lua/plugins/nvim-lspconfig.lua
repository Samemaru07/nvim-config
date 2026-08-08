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

	-- プロジェクトマーカがない単発スクリプトの場合、CWD全体ではなくそのファイル自身のディレクトリをルートにして無駄な全走査を防ぐ
	vim.lsp.config("pyright", {
		root_dir = function(bufnr, on_dir)
			local fname = vim.api.nvim_buf_get_name(bufnr)
			local root = vim.fs.root(fname, {
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				"pyrightconfig.json",
				".git",
			})
			on_dir(root or vim.fs.dirname(fname))
		end,
	}),
}
