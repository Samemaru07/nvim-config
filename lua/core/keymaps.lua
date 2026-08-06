-- 検索ハイライト機能
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- LSPキーマップ
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
    callback = function(event)
    local opts = { buffer = event.buf }
        -- 定義ジャンプ
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        -- 参照箇所一覧表示
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
        -- カーソルの型情報・ドキュメントをポップアップ表示する
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        -- カーソル位置のシンボル名をプロジェクト全体で一括リネーム
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        -- サーバが提案する修正候補を一覧から選んで▽適用する
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        -- 直前のエラー・警告の位置へカーソルを移動する
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        -- 次のエラー・警告の位置へカーソルを移動する
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    end,
})
