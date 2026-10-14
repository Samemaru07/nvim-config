return {
	"lervag/vimtex",
	ft = { "tex", "plaintex", "bib" },
	tag = "v2.18",
	init = function()
		local socket = "/tmp/nvim-socket-" .. (vim.env.NVIM_APPNAME or "nvim")

		vim.g.vimtex_socket = socket
		vim.g.vimtex_compiler_progname = "/home/samemaru/.local/bin/nvr"
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

		vim.g.vimtex_view_general_viewer = "zathura"
		vim.g.vimtex_view_general_options = '-x "/home/samemaru/.local/bin/nvr --servername '
			.. socket
			.. ' --remote-silent +%{line} %{input}" --synctex-forward @line:0:@tex @pdf'
	end,
	config = function()
		vim.fn.delete(vim.g.vimtex_socket)
		vim.fn.serverstart(vim.g.vimtex_socket)
	end,
}
