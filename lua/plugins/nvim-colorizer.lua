return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		options = {
			parsers = {
				hex = {
					defalt = true,
					hash_aarrggbb = true,
					rrggbbaa = false,
				},
			},
		},
	},
}
