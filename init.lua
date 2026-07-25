-- Leader Key (プラグインマネージャ導入時にも影響するため，requireよりも前に設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")
