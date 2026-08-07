local map = vim.keymap.set
local opts = { silent = true }

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

-- TODO: vim-processing 導入時に使用
-- local processing_job_id = nil

local function format_and_save()
	local conform = require("conform")
	conform.format({ quiet = true }, function(err)
		if err and not err:find("No formatters available") then
			vim.fn.setqflist({ { text = "Conform: " .. err, type = "E" } })
			vim.cmd("copen")
		end
		if vim.fn.expand("%") ~= "" then
			vim.cmd("write")
		end

		local ft = vim.bo.filetype

		-- TODO: Phase 7でvimtex導入後に有効化
		-- if ft == "tex" or ft == "latex" or ft == "bib" then
		--     local info = vim.b.vimtex
		--     if info and type(info.compiler) == "table" then
		--         if info.compiler.status ~= 2 then
		--             vim.cmd("VimtexCompile")
		--         end
		--     end
		-- end

		-- TODO: Phase 7でvim-processing導入後に有効化
		-- if ft == "processing" then
		--     if processing_job_id then
		--         vim.fn.jobstop(processing_job_id)
		--     end
		--
		--     local dir = vim.fn.expand("%:p:h")
		--     processing_job_id = vim.fn.jobstart("processing-java --sketch=" .. dir .. " --run", {
		--         stderr_buffered = true,
		--         on_stderr = function(_, data)
		--             if data and #data > 0 then
		--                 local items = {}
		--                 for _, line in ipairs(data) do
		--                     local file, lnum, col, msg = line:match("(.+):(%d+):(%d+):%d+:%d+: (.+)")
		--                     if file and lnum then
		--                         table.insert(items, {
		--                             filename = file,
		--                             lnum = tonumber(lnum),
		--                             col = tonumber(col),
		--                             text = msg,
		--                             type = "E",
		--                         })
		--                     end
		--                 end
		--                 if #items > 0 then
		--                     vim.fn.setqflist(items)
		--                     vim.cmd("copen")
		--                 end
		--             end
		--         end,
		--     })
		-- end
	end)
end

map({ "n", "i", "v" }, "<C-s>", format_and_save, opts)

map({ "n", "v" }, "<leader>sq", function()
	format_and_save()
	vim.cmd("bdelete")
end, opts)

map("n", "<leader>q", "<cmd>Bdelete!<CR>", opts)

-- TODO: lua/data/messages.lua移植後, notify_random経由の通知付き処理に戻す
map({ "n", "v" }, "<C-c>", '"+y', opts)
map({ "n", "v" }, "<C-v>", '"+p', opts)

map("i", "<C-v>", '<C-o>"+p', opts)

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

-- TODO: lua/data/messages.lua移植後、notify_random経由の通知付き処理に戻す
map("n", "dd", '"_dd', opts)
map("n", "<leader>x", '"+dd', opts)
map("n", "xx", '"+dd', opts)
map("x", "d", '"_d', opts)
map("x", "x", '"+d', opts)

map("i", "<C-h>", "<C-w>", opts)
map("n", "<C-h>", "db", opts)

map("i", "<C-l>", "<C-o>de", opts)
map("n", "<C-l>", "de", opts)

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

-- Phase 7でskkeleton導入予定のため一時コメントアウト
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "skkeleton-initialize-pre",
--     callback = function()
--         vim.fn["skkeleton#register_keymap"]("input", "q", "katakana")
--         vim.fn["skkeleton#register_keymap"]("input", "Q", "hankatakana")
--         vim.fn["skkeleton#register_keymap"]("input", "<C-j>", "disable")
--         vim.fn["skkeleton#register_keymap"]("input", "<C-g>", "escape")
--         vim.fn["skkeleton#register_keymap"]("henkan", "<C-g>", "escape")
--     end,
-- })
--
-- map({ "i", "c" }, "<C-j>", [[<Plug>(skkeleton-toggle)]], { remap = true })

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
