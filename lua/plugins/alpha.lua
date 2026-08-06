-- ダッシュボード
return {
    "goolord/alpha-nvim",
    event = "vimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find File", "<cmd>Telescope find_files<cr>"),
            dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
            dashboard.button("g", "  Live Grep", "<cmd>Telescope live_grep<cr>"),
            dashboard.button("e", "  File Explorer", "<cmd>Neotree toggle<cr>"),
            dashboard.button("n", "  New File", "<cmd>enew<cr>"),
            dashboard.button("l", "  Lazy", "<cmd>Lazy<cr>"),
            dashboard.button("q", "  Quit", "<cmd>qa<cr>")
        }

        alpha.setup(dashboard.config)
    end
}
