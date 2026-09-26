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
			vim.opt_local.formatoptions:remove("r")

			vim.keymap.set("i", "<Tab>", function()
				if vim.fn["pum#visible"]() then
					vim.fn["pum#map#insert_relative"](1)
					return
				end
				vim.cmd("AutolistTab")
			end, opts)
			vim.keymap.set("i", "<S-Tab>", function()
				if vim.fn["pum#visible"]() == 1 then
					vim.fn["pum#map#insert_relative"](-1)
					return
				end
				vim.cmd("AutolistShiftTab")
			end, { buffer = true })
			vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
			vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
			vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
			vim.keymap.set("n", "<leader>r", "<cmd>AutolistRecalculate<cr>")
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

				-- 前行がテキスト未入力の空マーカーのままEnterを押した場合、マーカーを消去して平文に戻す
				if is_empty_marker(prev) and (cur == "" or is_empty_marker(cur)) then
					vim.api.nvim_buf_set_lines(0, row - 2, row, false, { "" })
					vim.api.nvim_win_set_cursor(0, { row - 1, 0 })
					return
				end

				-- 前行が内容のあるリストの場合のみ、改行直後に次行マーカーを自動補完
				if cur == "" then
					local prev_indent, prev_num = prev:match("^(%s*)(%d+)%.%s+(%S+)")
					if prev_num then
						local indent, num = prev:match("^(%s*)(%d+)%.%s+")
						local next_num = tostring(tonumber(num) + 1)
						local new_line = indent .. next_num .. ". "
						vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
						vim.api.nvim_win_set_cursor(0, { row, #new_line })
						return
					end

					local prev_indent_bullet, prev_bullet = prev:match("^(%s*)([%-%*%+])%s+(%S+)")
					if prev_bullet then
						local indent, bullet = prev:match("^(%s*)([%-%*%+])%s+")
						local new_line = indent .. bullet .. " "
						vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
						vim.api.nvim_win_set_cursor(0, { row, #new_line })
					end
				end
			end,
		})
	end,
}
