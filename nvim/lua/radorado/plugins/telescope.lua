return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

			-- We want to close telescope even when we are in insert mode there
			-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-esc-to-quit-in-insert-mode
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
			})

			require("telescope").load_extension("fzf")

			vim.keymap.set("n", "<C-p>", function()
				local ok, _ = pcall(builtin.git_files)

				if not ok then
					builtin.find_files()
				end
			end, { desc = "Telescope find files" })

			vim.keymap.set("n", "<C-s>", builtin.live_grep, { desc = "Telescope live grep" })
		end,
	},
}
