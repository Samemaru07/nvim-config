-- 単体では機能しない共有ライブラリ．
-- lazy.nvimのトリガはこのファイルではなく依存する側のspecで指定
return {
    "nvim-lua/plenary.nvim",
    lazy = true
}
