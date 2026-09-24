return {
	"gaoDean/autolist.nvim",
	ft = {
		"markdown",
		"text",
		"tex",
		"plaintex",
	},
	config = function()
		local autolist = require("autolist")
		autolist.setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown", "text", "tex", "plaintex" },
			callback = function()
				local opts = { buffer = true }

				vim.opt_local.comments = { "b:-", "b:*", "b:+", "b:1." }
				vim.opt_local.formatoptions:append("r")
				vim.opt_local.formatoptions:append("o")

				-- 空のリスト行でEnterを押した場合はマーカーを消去して平文に戻す
				vim.keymap.set("i", "<CR>", function()
					local line = vim.api.nvim_get_current_line()
					if line:match("^%s*[%-%*%+]%s*$") or line:match("^%s*%d+%.%s*$") then
						return "<C-u><CR>"
					end
					return "<CR>"
				end, { buffer = true, expr = true })

				vim.keymap.set("i", "<Tab>", "<cmd>AutolistTab<cr>", opts)
				vim.keymap.set("i", "<S-Tab>", "<cmd>AutolistShiftTab<cr>", opts)
				vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
				vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
				vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
				vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>", opts)
				vim.keymap.set({ "n", "v" }, ">>", ">><cmd>AutolistRecalculate<cr>", opts)
				vim.keymap.set({ "n", "v" }, "<<", "<<<cmd>AutolistRecalculate<cr>", opts)
				vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
				vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>", opts)
			end,
		})
	end,
}
