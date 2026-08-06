return {
	"neovim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local languages = {
			"lua",
			"python",
			"latex",
			"markdown",
			"markdown_inline", -- markdownと対で必要 (コードブロック内等のインライン要素のハイライト用)
			"html",
			"css",
			"typescript",
			"javascript",
			"bash",
		}

		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldmethod = "expr"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
