local checktime_group = vim.api.nvim_create_augroup("checktime-on-external-change", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose" }, {
	group = checktime_group,
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})
