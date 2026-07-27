-- ファジーファインダー (ファイル検索・grep・バッファ一覧なおどぉ1つのUIに集約)
-- keysを読み込みトリガーとする (キーが押されたら読み込む)
return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" }
    },
    -- keysで読み込まれた後，fzf-native拡張を明示的に有効化する
    -- load_extensionはtelescope自身のsetup()とは独立した処理なので，
    -- ops (自動setup呼び出し) ではなくconfigで手動で呼ぶ必要がある．
    config = function()
        require("telescope").load_extension("fzf")
    end
}
