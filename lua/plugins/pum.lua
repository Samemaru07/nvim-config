return {
	"Shougo/pum.vim",
	lazy = false,
	config = function()
		vim.keymap.set("i", "<Tab>", function()
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#insert_relative(+1)<CR>"
			end
			return "<Tab>"
		end, { expr = true, replace_keycodes = true })

		vim.keymap.set("i", "<S-Tab>", function()
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#insert_relative(-1)<CR>"
			end
			return "<S-Tab>"
		end, { expr = true, replace_keycodes = true })
	end,
}
