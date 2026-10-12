local map = vim.keymap.set
local opts = { silent = true }
local messages = require("data.messages")

vim.opt.signcolumn = "yes"

map("n", "<leader>h", "<C-w>h", opts)
map("n", "<leader>j", "<C-w>j", opts)
map("n", "<leader>k", "<C-w>k", opts)
map("n", "<leader>l", "<C-w>l", opts)

map("t", "<C-g>", "<C-\\><C-n>", { silent = true, nowait = true })
map({ "i", "v", "c", "s", "o" }, "<C-g>", "<Esc>", { silent = true, nowait = true })
map("n", "<C-g>", "<Nop>", { silent = true, nowait = true })

map("t", "<C-Right>", "\x1bf")
map("t", "<C-Left>", "\x1bb")

-- ヘルパー: レジスタの行数を数える
local function count_lines(text)
	if text == "" then
		return 1
	end
	local nl_count = 0
	for _ in string.gmatch(text, "\n") do
		nl_count = nl_count + 1
	end
	if string.sub(text, -1) == "\n" then
		return nl_count
	else
		return nl_count + 1
	end
end

local function lines_str(text)
	local n = count_lines(text)
	return n > 1 and n .. "行" or "1行"
end

local function notify_random(list, level, fmt_arg)
	local selected = list[math.random(1, #list)]
	local msg = fmt_arg and string.format(selected.message, fmt_arg) or selected.message
	vim.notify(msg, level, { title = selected.title })
end

-- 削除後に番号付きリストの番号を詰めるため、Markdownのときだけ再計算する
local function recalc_markdown_list()
	if vim.bo.filetype == "markdown" then
		pcall(vim.cmd, "AutolistRecalculate")
	end
end

local function format_and_save()
	local bufnr = vim.api.nvim_get_current_buf()
	local conform = require("conform")

	conform.format({ quiet = true, bufnr = bufnr }, function(err)
		vim.schedule(function()
			if err and not err:find("No formatters available") then
				vim.fn.setqflist({ { text = "Conform: " .. err, type = "E" } })
				vim.cmd("copen")
			end

			if vim.api.nvim_buf_get_name(bufnr) ~= "" then
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("write")
				end)
			end

			local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

			if ft == "tex" or ft == "latex" or ft == "bib" then
				local ok, info = pcall(vim.api.nvim_buf_get_var, bufnr, "vimtex")
				if ok and type(info) == "table" and type(info.compiler) == "table" then
					vim.api.nvim_buf_call(bufnr, function()
						if info.compiler.status ~= 2 then
							vim.cmd("VimtexCompile")
						end
					end)
				end
			end
		end)
	end)
end

map({ "n", "i", "v" }, "<C-s>", format_and_save, opts)

map({ "n", "v" }, "<leader>sq", function()
	format_and_save()
	vim.cmd("bdelete")
end, opts)

map("n", "<leader>q", "<cmd>Bdelete!<CR>", opts)

-- yをマップするとオペレータとして機能しなくなるため、通知はTextYankPostで行う
-- getreg("+")はWSLでwin32yankの外部プロセスを呼ぶため、イベントの内容を使う
-- TextYankPost内はテキストロック中で、通知プラグインがウィンドウを作れない(E565)ため、vim.scheduleで後回しにする
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.v.event.operator ~= "y" then
			return
		end
		local text = table.concat(vim.v.event.regcontents, "\n")
		vim.schedule(function()
			notify_random(messages.yank, vim.log.levels.INFO, lines_str(text))
		end)
	end,
})

-- ビジュアルモードのPは、置換されたテキストをレジスタに入れないため
-- pをマップしても、カウント(3pなど)とレジスタ指定("ap)が効くよう、v:count1とv:registerを引き継ぐ
map("n", "p", function()
	local reg = vim.v.register
	local count = vim.v.count1
	local text = vim.fn.getreg(reg)

	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"
	vim.cmd('noautocmd silent! normal! "' .. reg .. count .. "p")
	vim.o.shortmess = old_shortmess

	notify_random(messages.paste, vim.log.levels.INFO, lines_str(text))
end, opts)

-- ビジュアルモードのPは、置換されたテキストをレジスタに入れないため
map("x", "p", function()
	local reg = vim.v.register
	local text = vim.fn.getreg(reg)

	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"
	vim.cmd('noautocmd silent! normal! "' .. reg .. "P")
	vim.o.shortmess = old_shortmess

	notify_random(messages.paste, vim.log.levels.INFO, lines_str(text))
end, opts)

local function select_all()
	vim.cmd("normal! ggVG")
end
map({ "n", "v" }, "<C-a>", select_all, opts)

local resize_maps = {
	["<A-Up>"] = "<cmd>resize +2<CR>",
	["<A-Down>"] = "<cmd>resize -2<CR>",
	["<A-Left>"] = "<cmd>vertical resize -2<CR>",
	["<A-Right>"] = "<cmd>vertical resize +2<CR>",
}

for k, cmd in pairs(resize_maps) do
	map({ "n", "i", "v" }, k, "<Esc>" .. cmd .. "i", opts)
	map("n", k, cmd, opts)
	map("t", k, "<C-\\><C-n>" .. cmd .. "i", opts)
end

map({ "n", "v" }, "<leader>c<Up>", "ddkP", opts)
map({ "n", "v" }, "<leader>c<Down>", "ddp", opts)

map({ "n", "v" }, "<leader>cu", "yypk", opts)
map({ "n", "v" }, "<leader>cd", "yyp", opts)

map("n", "dd", function()
	local current_line_text = vim.api.nvim_get_current_line()
	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"

	-- プラグインの干渉が消えたため、標準のブラックホール削除が100%機能します
	vim.cmd('silent! normal! "_dd')

	vim.o.shortmess = old_shortmess
	recalc_markdown_list()
	notify_random(messages.delete, vim.log.levels.WARN, lines_str(current_line_text))
end, opts)

local function cut_line()
	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"
	vim.cmd('noautocmd silent! normal! "+dd')
	vim.o.shortmess = old_shortmess

	notify_random(messages.cut, vim.log.levels.WARN, "1行")
end

map("n", "<leader>x", cut_line, opts)
map("n", "xx", cut_line, opts)

map("x", "d", function()
	-- "_dはレジスタを更新しないため、削除前に選択範囲の行数を数える
	local n = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1
	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"
	vim.cmd('noautocmd silent! normal! "_d')
	vim.o.shortmess = old_shortmess

	recalc_markdown_list()
	notify_random(messages.delete, vim.log.levels.WARN, n .. "行")
end, opts)

map("x", "x", function()
	local old_shortmess = vim.o.shortmess
	vim.o.shortmess = old_shortmess .. "A"
	vim.cmd('noautocmd silent! normal! "+d')
	vim.o.shortmess = old_shortmess

	notify_random(messages.cut, vim.log.levels.WARN, lines_str(vim.fn.getreg("+")))
end, opts)

map({ "n", "v" }, "<leader>bv", "<cmd>vsplit<CR>", opts)
map({ "n", "v" }, "<leader>bh", "<cmd>split<CR>", opts)

map("n", "<leader>fc", function()
	require("spectre").open()
end, opts)

map("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)

for i = 1, 9 do
	map("n", "<leader>" .. i, function()
		require("bufferline").go_to(i, true)
	end, opts)
end

map("n", "<leader>rr", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") or name:match("^ui") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	vim.notify("Neovim Config Reloaded (Full)!", vim.log.levels.INFO)
end, opts)

map("n", "zz", "zz", opts)

map("n", "<leader>.", "<cmd>BufferLineCycleNext<CR>", opts)
map("n", "<leader>,", "<cmd>BufferLineCyclePrev<CR>", opts)

map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)
map({ "n", "v" }, "<S-e>", "%", opts)

map({ "n", "v" }, "<leader><Up>", ":m .-2<CR>==", opts)
map({ "n", "v" }, "<leader><Down>", ":m .+1<CR>==", opts)
map("v", "<leader><Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<leader><Down>", ":m '>+1<CR>gv=gv", opts)

vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-initialize-pre",
	callback = function()
		vim.fn["skkeleton#register_keymap"]("input", "q", "katakana")
		vim.fn["skkeleton#register_keymap"]("input", "Q", "hankatakana")
		vim.fn["skkeleton#register_keymap"]("input", "<C-j>", "disable")
		vim.fn["skkeleton#register_keymap"]("input", "<C-g>", "escape")
		vim.fn["skkeleton#register_keymap"]("henkan", "<C-g>", "escape")
	end,
})

-- SKK有効時、blink.cmpの補完ウィンドウが開いたま残り続けるバグの対策
-- (skkeletonが補完テキストの変化をblink.cmpに正しく伝えられず、自動で閉じないため)
vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-enable-pre",
	callback = function()
		require("blink.cmp").hide()
	end,
})

map({ "i", "c" }, "<C-j>", [[<Plug>(skkeleton-toggle)]], { remap = true })

-- nvim-surround
map("n", "<leader>w", "ysiw", { remap = true, desc = "Surround Word" })
map("n", "<leader>W", "yss", { remap = true, desc = "Surround Line" })
map("n", "<leader>dq", "dsq", { remap = true, desc = "Delete Quotes" })
map("n", "<leader>cq", "csq", { remap = true, desc = "Change Quote to ()" })

-- 16進数表示のトグル機能
vim.api.nvim_create_user_command("HexToggle", function()
	local is_hex = vim.b.is_hex or false
	if is_hex then
		-- 16進数から元に戻す
		vim.cmd("%!xxd -r")
		vim.b.is_hex = false
	else
		-- 16進数ダンプに変換する
		vim.cmd("%!xxd")
		vim.b.is_hex = true
	end
end, { desc = "Toggle Hex View" })

-- LSPキーマップ
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
	callback = function(event)
		local buf_opts = { buffer = event.buf }
		-- 定義ジャンプ
		map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", buf_opts, { desc = "Go to definition" }))
		-- 参照箇所一覧表示
		map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", buf_opts, { desc = "Find references" }))
		-- カーソルの型情報・ドキュメントをポップアップ表示する
		map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", buf_opts, { desc = "Hover documentation" }))
		-- カーソル位置のシンボル名をプロジェクト全体で一括リネーム
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", buf_opts, { desc = "Rename symbol" }))
		-- サーバが提案する修正候補を一覧から選んで適用する
		map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", buf_opts, { desc = "Code action" }))
		-- 直前のエラー・警告の位置へカーソルを移動する
		map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", buf_opts, { desc = "Previous diagnostic" }))
		-- 次のエラー・警告の位置へカーソルを移動する
		map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", buf_opts, { desc = "Next diagnostic" }))
	end,
})

-- Lazygit
local lazygit

map("n", "<leader>g", function()
	if not lazygit then
		local Terminal = require("toggleterm.terminal").Terminal
		lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			close_on_exit = true,
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})
	end
	lazygit:toggle()
end, opts)

-- change・substitute・行末削除をブラックホール行きにし、クリップボードを汚さない
map({ "n", "x" }, "c", '"_c', opts)
map("n", "C", '"_C', opts)
map("n", "s", '"_s', opts)
map("n", "S", '"_S', opts)
map("n", "D", '"_D', opts)
