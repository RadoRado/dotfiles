return {
	{
		"ThePrimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
			vim.keymap.set("n", "<C-l>", mark.clear_all)
			vim.keymap.set("n", "<C-h>", mark.add_file)
		end,
	},
}
