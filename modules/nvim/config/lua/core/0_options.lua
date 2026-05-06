-- Shortcuts
local o = vim.opt
local g = vim.g

-- Leader
g.mapleader = " "

-- Disable built-in plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- UI
o.termguicolors = true
o.guifont = "JetBrainsMono Nerd Font Mono"

o.number = true
o.relativenumber = true
o.cursorline = true

o.wrap = false
o.scrolloff = 4
o.splitright = true
o.smoothscroll = true

o.showmode = false
o.confirm = true

vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })

-- Tabs / indentation
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- -- Whitespace / invisible chars
-- o.list = true
-- o.listchars:append({
-- 	lead = "⋅",
-- })

-- File handling
o.fileformat = "unix"
