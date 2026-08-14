-- 括弧・クォート等を開いた瞬間，閉じ側を自動挿入する
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- インサートモードに入った瞬間に読み込む
	opts = {},
}
