return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
    {
      "<leader>xt",
      "<cmd>Trouble todo toggle<cr>",
      desc = "Toggle todo list",
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Toggle diagnostics list",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Toggle quickfix list",
    }
  }
}
