return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig"
    },
    opts = {
        ensure_installed = {} -- 使う言語が決まり次第, ここにサーバ名を追記していく
    }
}
