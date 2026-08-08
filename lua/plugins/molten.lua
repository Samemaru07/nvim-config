return {
	"benlubas/molten-nvim",
	version = "^1.0.0",
	lazy = false,
	build = ":UpdateRemotePlugins",
	dependencies = { "3rd/image.nvim" },
	init = function()
		vim.g.python3_host_prog = vim.fn.expand("~/anaconda3/envs/py313/bin/python")

		vim.g.molten_image_provider = "none"
		vim.g.molten_auto_image_popup = true

		vim.g.molten_auto_open_output = true
		vim.g.molten_wrap_output = true
		vim.g.molten_virt_text_output = false
		vim.g.molten_virt_lines_off_by_1 = true
		vim.g.molten_output_win_max_height = 100
		vim.g.molten_output_show_exec_time = false
	end,
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<localleader>mi", "<cmd>MoltenInit<CR>", opts)
		map("n", "<localleader>me", "<cmd>MoltenEvaluateOperator<CR>", opts)
		map("n", "<localleader>ml", "<cmd>MoltenEvaluateLine<CR>", opts)
		map("n", "<localleader>mr", "<cmd>MoltenReevaluateCell<CR>", opts)
		map("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", opts)
		map("n", "<localleader>md", "<cmd>MoltenDelete<CR>", opts)
		map("n", "<localleader>mh", "<cmd>MoltenHideOutput<CR>", opts)
		map("n", "<localleader>mo", "<cmd>noautocmd MoltenEnterOutput<CR>", opts)
		map("n", "<localleader>mn", "<cmd>MoltenNext<CR>", opts)
		map("n", "<localleader>mp", "<cmd>MoltenPrev<CR>", opts)
		map("n", "<localleader>mx", "<cmd>MoltenInterrupt<CR>", opts)
		map("n", "<localleader>mR", "<cmd>MoltenRestart!<CR>", opts)
	end,
}
