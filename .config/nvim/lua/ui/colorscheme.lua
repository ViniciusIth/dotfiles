return {
    {
        "https://git.sr.ht/~swaits/colorsaver.nvim",
        lazy = true,
        event = "VimEnter",
        opts = {
        },
        dependencies = {
            { "catppuccin/nvim",               opts = { transparent = true, }, name = "catppuccin" },
            { "folke/tokyonight.nvim",         opts = { transparent = true, }, },
            { "rebelot/kanagawa.nvim",         opts = { transparent = true, }, },
            { "sainnhe/gruvbox-material",      opts = { transparent = true, }, },
        },
    },
}
