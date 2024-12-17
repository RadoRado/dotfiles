-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {"lua_ls", "pyright"},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

require('lspconfig').pyright.setup({
    -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
    -- https://github.com/DNSLV-PMTKV/dotfiles/blob/main/nvim/lua/plugins/lspconfig.lua#L146
    settings = {
        pyright = {
            -- disableLanguageServices = true
        },
        python = {
            analysis = {

            }
        }
    }
})

---
-- Autocompletion config
---
-- local cmp = require('cmp')
--
-- cmp.setup({
--     sources = {
--         {name = 'nvim_lsp'},
--     },
--     mapping = cmp.mapping.preset.insert({
--         -- `Enter` key to confirm completion
--         ['<CR>'] = cmp.mapping.confirm({select = false}),
--
--         -- Ctrl+Space to trigger completion menu
--         ['<C-Space>'] = cmp.mapping.complete(),
--
--         -- Scroll up and down in the completion documentation
--         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-d>'] = cmp.mapping.scroll_docs(4),
--     }),
--     snippet = {
--         expand = function(args)
--             vim.snippet.expand(args.body)
--         end,
--     },
-- })
