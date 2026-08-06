return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        {
            "<leader>sr",
            function()
                require("spectre").toggle()
            end,
            desc = "Toggle Spectre"
        }
    }
}
