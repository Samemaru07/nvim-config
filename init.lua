-- ==========
-- Leader Key (最初に設定する．以降のkeymapで使うため)
-- ==========
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ==========
-- 表示
-- ==========
vim.opt.number = true -- 行番号
vim.opt.relativenumber = true -- 相対行番号
vim.opt.cursorline = true -- カーソ行をハイライト
vim.opt.termguicolors = true -- 24bitカラー
vim.opt.signcolumn = "yes" -- 診断アイコン等の列を常時確保
vim.opt.scrolloff = 8 -- カーソルが画面端に来る前に余白を残す
vim.opt.wrap = false -- 折り返さない

-- ==========
-- インデント
-- ==========
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ==========
-- 検索
-- ==========
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ==========
-- ファイル管理
-- ==========
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- ==========
-- ウィンドウ管理
-- ==========
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ==========
-- クリップボード
-- ==========
-- WSL: win32yank.exe がPATH経由で自動検出される
-- Arch: xclip または wl-clipboardの導入を別途確認
vim.opt.clipboard = "unnamedplus"

-- ============================================
-- OS別設定（現状は分岐不要。将来ここに追記していく置き場所）
-- ============================================
-- local is_wsl = vim.fn.has("wsl") == 1
--
-- [Arch専用・保留]
-- if not is_wsl then
--   -- 例: GUIフォント指定、xclip固有の挙動調整など
--   -- vim.opt.guifont = "..."
-- end

-- ==========
-- 最低限のkeymap
-- ==========
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") 
