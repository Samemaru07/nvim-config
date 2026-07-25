-- 表示
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
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

-- クリップボード (WSL: win32yank自動検出．Archではxclip/wl-clipboard要確認
vim.opt.clipboard = "unnamedplus"

-- OS別設定
-- local is_wsl = vim.fn.has("wsl") == 1
-- if not is_wsl then
--  -- [Arch 専用・保留]
--  end
