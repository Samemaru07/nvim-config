return {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown" },
	cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
	build = "cd app && npm install",
	init = function()
		-- デフォルトのブラウザ起動処理を差し替え、Hyperのwebview機能でプレビューURLを開く。
		-- Hyperの分割ペイン (webview表示待受中) へ貼り付けて使う想定
		-- VimScript側からnotifyを呼び出すため、Lua関数を _G に公開
		_G.mkdp_preview_url_notify = function()
			vim.notify(
				"プレビュー用のURLをクリップボードに送りましたーっ！ さあさあ、ブラウザを開いて接続してみてくださいよぉ！",
				vim.log.levels.INFO,
				{ title = "[タチコマ] ネットは広大だわ…じゃなくて！" }
			)
		end

		vim.g.mkdp_browserfunc = "OpenMarkdownPreviewInHyperWebview"
		vim.cmd([[
      function! OpenMarkdownPreviewInHyperWebview(url)
        call setreg('+', a:url)
      call v:lua.mkdp_preview_url_notify()
      endfunction
    ]])
	end,
}
