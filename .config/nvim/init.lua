require("general.settings")
require("general.keymaps")

-- Lazy.nvim bootstraping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "lsp" },
    { import = "text" },
    { import = "tools" },
    { import = "ui" },
})

require("general.autocmds")

-- -- set the background color to match the editor theme
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NvimTreeNormal guibg=NONE ctermbg=NONE")
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
