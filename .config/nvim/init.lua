vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.mapleader = " "
vim.opt.termguicolors = true

require("config.options")
require("plugins")
require("config.mappings")

vim.notify = require("notify")

if vim.g.neovide then
    require("config.neovide")
end

vim.cmd.colorscheme "catppuccin"

-- set the background color to match the editor theme
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NvimTreeNormal guibg=NONE ctermbg=NONE")

