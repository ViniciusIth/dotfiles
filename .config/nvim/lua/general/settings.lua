local o = vim.opt
local g = vim.g

g.loaded_netrwPlugin = 1
g.loaded_netrw = 1
g.mapleader = " "

o.termguicolors = true
o.guifont = "JetBrainsMono Nerd Font Mono"

-- Tab width etc
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Enable line numbers
o.number = true
o.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })

-- Misc
o.ignorecase = true
o.smartcase = true
o.wrap = false
o.hlsearch = false
o.showmode = false
o.scrolloff = 4
o.splitright = true
