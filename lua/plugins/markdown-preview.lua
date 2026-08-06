return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    -- デフォルトのブラウザ起動処理を差し替え、Hyperのwebview機能でプレビューURLを開く
    -- TODO: Hyper側のwebview起動コマンドが確定したら、下記コマンド文字列を実装に合わせて書き換える
    vim.g.mkdp_browserfunc = "OpenMarkdownPreviewInHyperWebview"
    vim.cmd([[
      function! OpenMarkdownPreviewInHyperWebview(url)
        " 例: Hyper側にURLを渡すコマンドをここに実装する
        " call system('hyper-webview-open ' . shellescape(a:url))
      endfunction
    ]])
  end,
}
