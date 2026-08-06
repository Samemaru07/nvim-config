-- telescopeの検索アルゴリズムを，デフォルトのLua実装からC言語実装のfzfに置き換える拡張
return {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make" -- clone直後または更新時に1回だけ実行するシェルコマンド
}
