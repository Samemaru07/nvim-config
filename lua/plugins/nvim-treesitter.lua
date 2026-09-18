return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"lua",
			"python",
			"c",
			"latex",
			"markdown",
			"markdown_inline",
			"html",
			"css",
			"typescript",
			"tsx",
			"javascript",
			"bash",
		}

		local filetypes = {
			"lua",
			"python",
			"c",
			"tex",
			"markdown",
			"html",
			"css",
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"sh",
		}

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldmethod = "expr"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
