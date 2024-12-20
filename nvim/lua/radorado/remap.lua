-- custom keybindings
-- n: Normal mode.
-- i: Insert mode.
-- x: Visual mode.
-- s: Selection mode.
-- v: Visual + Selection.
-- t: Terminal mode.
-- o: Operator-pending.
-- '': Yes, an empty string. Is the equivalent of n + v + o.

-- ,w saves
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })

-- select entire file
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")
vim.keymap.set("n", "<C-a>", ":keepjumps normal! ggVG<cr>")

-- copy from clipboard
vim.keymap.set({ "x" }, "<C-c>", '"+y')
vim.keymap.set({ "x" }, "gy", '"+y')
-- paste from clipboard
vim.keymap.set({ "n", "x" }, "gp", '"+p')

-- When we delete text in normal mode or visual mode using c, d or x that text goes to a register.
-- This affects the text we paste with the keybinding p.
-- What I do is modify x and X to delete text without changing the internal registers.
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

-- Move selected lines up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Moves the line below, while the cursor stays in place
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "Q", "<nop>")
