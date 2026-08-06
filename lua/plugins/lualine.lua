-- ステータスライン．
-- VeryLazyイベント (起動直後・最初の描画が終わったタイミングで読み込む
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- VeryLazyイベントが発火して，lualineのdependenciesのopts→setupを読み込み，その後lualine自身のopts→setupを読み込む
    opts = {
        options = {
            theme = "kanagawa"
        }
    }
}
