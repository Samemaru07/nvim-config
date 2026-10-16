return {
	"lervag/vimtex",
	lazy = false,
	tag = "v2.18",
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
		vim.g.vimtex_indent_debug = 0
		vim.g.vimtex_compiler_latexmk = {
			continuous = 1,
			out_dir = ".build",
			options = {
				"-synctex=1",
				"-interaction=nonstopmode",
				"-file-line-error",
				"-halt-on-error",
				"-shell-escape",
			},
		}
	end,
}
