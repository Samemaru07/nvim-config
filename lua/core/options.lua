-- 表示
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
	foldopen = "v",
	foldclose = ">",
	foldsep = " ",
	foldinner = " ",
}
vim.opt.scrolloff = 3
vim.opt.wrap = false

-- インデント
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 検索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ウィンドウ分割
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ファイル管理
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- クリップボード
-- 同期するスイッチ
vim.opt.clipboard = "unnamedplus"

-- インサートモードで自作ターミナルの貼り付け（超高速タイピング）が始まったら、
-- 自動でペーストモードに切り替えてインデント崩れを防ぐ設定（Neovim標準の仕組みを利用）
vim.opt.paste = false -- 普段はオフ

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

vim.opt.foldlevelstart = 99

vim.opt.autoread = true

-- プラグイン初回取得時の build でも venv の Python を使えるよう、プラグイン定義の外で指定
vim.g.python3_host_prog = vim.fn.stdpath("data") .. "/venv/bin/python"

-- 「n行がヤンクされました」のメッセージを出さないよう、閾値を無限大に
vim.opt.report = 9999
