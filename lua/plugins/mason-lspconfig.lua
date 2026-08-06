return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig"
    },
    opts = {
        -- サーバ名
        -- 補完・診断・定義ジャンプ・参照検索・ホバー・リネーム・コードアクションを提供してくれる
        ensure_installed = {
            "lua_ls",
            "pyright",
            "texlab",
            "marksman",
            "html",
            "cssls",
            "ts_ls",
            "bashls"
        } 
    }
}
