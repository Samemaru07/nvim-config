-- 差分がある行の左端に印を表示する
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- BufReadPre: 既存ファイルを開く直前, BufNewFile: まだ存在しない新規ファイル名で開いたとき
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
}
