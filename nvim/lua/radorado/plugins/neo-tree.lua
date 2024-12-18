return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
            require("neo-tree").setup({
                enable_git_status = false,
                filesystem = {
                    filtered_items = {
                        hide_gitignored = true,
                        hijack_netrw_behavior = "open_current",
                    },
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = false
                    },
                    buffers = {
                        follow_current_file = {
                            enable = true,
                            leave_dirs_open = false
                        }
                    },
                }

            })
            -- If we are using neo-tree, we don't want to use netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
        end
    }
}
