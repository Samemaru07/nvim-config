return {
    "folke/lazydev.nvim",
    ft = "lua", -- .luaファイルを開いたときだけ読み込む
    opts = {
        library = {
            -- luvit-meta型スタブを読み込み，vim.uv (libuv) の補完・型チェックを強化する
            { path = "luvit-meta/library", words = { "vim%.uv" } }
        }
    },
    dependencies = {
        { "Bilal2453/luvit-meta", lazy = true }
    }
}
