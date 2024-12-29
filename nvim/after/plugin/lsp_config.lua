-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to definition + jump back
		map("<leader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto [D]efinition")
		map("<leader>b", ":pop<cr>", "Jump [B]ack")

		-- Remap the "goto local definition"
		-- https://neovim.io/doc/user/pattern.html#gd
		vim.keymap.set("n", "<leader>i", "gd", { remap = true, desc = "LSP: Goto [I]mport" })

		local builtin = require("telescope.builtin")
		-- map("<leader>r", "<cmd>lua vim.lsp.buf.references()<cr>", "View [R]eferences")
		map("<leader>r", builtin.lsp_references, "View [R]eferences")

		-- Rename via the LSP
		map("<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
	end,
})

require("mason").setup({})
require("mason-lspconfig").setup({
	-- Perhaps we can go with automatic_installation = true
	automatic_installation = false,
	ensure_installed = { "lua_ls", "pyright", "ts_ls" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

require("lspconfig").pyright.setup({
	-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
	-- https://github.com/DNSLV-PMTKV/dotfiles/blob/main/nvim/lua/plugins/lspconfig.lua#L146
	-- WARN: Those settings are not going to take effect
	-- WARN: Because Python projects are running with a local pyrightconfig.json
	settings = {
		pyright = {},
		python = {
			analysis = {},
		},
	},
})

require("lspconfig").ts_ls.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
-- If you primarily use lua-language-server for Neovim, and want to provide completions,
-- analysis, and location handling for plugins on runtime path, you can use the following settings.
require("lspconfig").lua_ls.setup({
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		-- https://luals.github.io/wiki/settings/
		Lua = {
			diagnostics = { disable = { "missing-fields", "undefined-field" } },
		},
	},
})

---
-- Autocompletion config
-- Mostly based on https://lsp-zero.netlify.app/docs/autocomplete.html
---
local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	completion = {
		autocomplete = false,
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- Ctrl+Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- Simple tab complete
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item({ behavior = "select" })
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
	}),
	preselect = "item",
	-- snippet = {
	-- 	expand = function(args)
	-- 		vim.snippet.expand(args.body)
	-- 	end,
	-- },
})
