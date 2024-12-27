local o = vim.opt

-- Disable swap and enable undofiles
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath('config') .. "/.undodir"
vim.o.guifont = "JetBrainsMono Nerd Font Mono"

-- Tab width etc
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Enable line numbers
o.number = true
o.relativenumber = true

-- Misc
o.ignorecase = true
o.smartcase = true
o.wrap = false
o.hlsearch = false
o.showmode = false
o.scrolloff = 4
o.splitright = true
