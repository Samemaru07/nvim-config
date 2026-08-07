return {
	"mfussenegger/nvim-lint",
	-- リリースタグが存在しないプラグインのためのmain追従
	event = { "BufWritePost", "BufReadPost", "InsertLeave" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			sh = { "shellcheck" },
			c = { "cpplint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("Lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
