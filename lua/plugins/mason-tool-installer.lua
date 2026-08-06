return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        ensure_installed = {}, -- LSP/formatter/linterが決まり次第, ここに追記
    }
}
