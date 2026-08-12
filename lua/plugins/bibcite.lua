return {
	"aidavdw/bibcite.nvim",
	cmd = { "CiteOpen", "CiteInsert", "CitePeek", "CiteNote" },
	keys = {
		{ "<leader>ci", ":CiteInsert<CR>", desc = "Insert citation" },
		{ "<leader>cp", ":CitePeek<CR>", desc = "Peek citation info" },
		{ "<leader>co", ":CiteOpen<CR>", desc = "Open citation file" },
		{ "<leader>cn", ":CiteNote<CR>", desc = "Open citation note" },
	},
	opts = {
		bibtex_path = "./ref/references.bib",
		pdf_dir = "./ref/papers",
		notes_dir = "./ref/notes",
		text_file_open_mode = "vsplit",
	},
}
