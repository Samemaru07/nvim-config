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

		local target_fts = { markdown = true, text = true, tex = true, plaintex = true }

		local function is_empty_marker(line)
			return line:match("^%s*[%-%*%+]%s*$") ~= nil or line:match("^%s*%d+%.%s*$") ~= nil
		end

		local function setup_buffer()
			local opts = { buffer = true }

			vim.opt_local.comments = { "b:-", "b:*", "b:+", "b:1." }
			vim.opt_local.formatoptions:append("r")

			vim.keymap.set("i", "<Tab>", function()
				if vim.fn["pum#visible"]() then
					vim.fn["pum#map#insert_relative"](1)
					return
				end
				vim.cmd("AutolistTab")
			end, opts)
			vim.keymap.set("i", "<S-Tab>", function()
				if vim.fn["pum#visible"]() then
					vim.fn["pum#map#insert_relative"](-1)
					return
				end
				vim.cmd("AutolistShiftTab")
			end, opts)
			vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
			vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
			vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
			vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>", opts)
			vim.keymap.set({ "n", "v" }, ">>", ">><cmd>AutolistRecalculate<cr>", opts)
			vim.keymap.set({ "n", "v" }, "<<", "<<<cmd>AutolistRecalculate<cr>", opts)
			vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
			vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>", opts)
		end

		-- ft指定でのプラグイン読み込み時点で、現在のバッファは既にFileTypeイベントが
		-- 発火済みのため、以降のautocmdでは捕捉できない。ここで即時適用する。
		setup_buffer()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown", "text", "tex", "plaintex" },
			callback = setup_buffer,
		})

		-- 空のリスト行が連続した場合、マーカーを消去して平文の空行に戻す。
		-- <CR>自体は奪わない（skkeleton/blink.cmp/nvim-autopairsとの競合回避のため）。
		vim.api.nvim_create_autocmd("TextChangedI", {
			callback = function()
				if not target_fts[vim.bo.filetype] then
					return
				end
				local row = vim.api.nvim_win_get_cursor(0)[1]
				if row < 2 then
					return
				end
				local cur = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
				local prev = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1] or ""
				if is_empty_marker(cur) and is_empty_marker(prev) then
					vim.api.nvim_buf_set_lines(0, row - 2, row, false, { "" })
					vim.api.nvim_win_set_cursor(0, { row - 1, 0 })
				end
			end,
		})
	end,
}
