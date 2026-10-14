vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "if mode() != 'c' | checktime | endif",
})
