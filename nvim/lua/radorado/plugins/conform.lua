return {
	{
		"stevearc/conform.nvim",
		opts = {},

		config = function()
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "never",
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				},
			})

			vim.keymap.set("n", "<leader>f", function()
				print("Running formatter")
				require("conform").format()
			end)
		end,
	},
}
