return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 全てのLSPサーバに共通適用
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- プロジェクトマーカがない単発スクリプトは、ファイル自身のディレクトリをルートにする。
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
		})

		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"css",
				"javascriptreact",
				"typescriptreact",
			},
		})

		vim.lsp.config("tailwindcss", {
			filetypes = {
				"html",
				"css",
				"javascriptreact",
				"typescriptreact",
			},
		})

		vim.lsp.config("qmlls", {
			cmd = { "/usr/lib/qt6/bin/qmlls", "-E" },
		})
		vim.lsp.enable("qmlls")

		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
		})
	end,
}
