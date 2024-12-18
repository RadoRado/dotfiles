-- fat cursor in insert mode
vim.opt.guicursor = ""
-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- allow mouse in all modes
vim.opt.mouse = 'a'

vim.opt.cursorline = true
vim.opt.autoindent = true

-- search related configs
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable highlighting of previous search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.g.mapleader = ','
vim.g.maplocalleader = ','
