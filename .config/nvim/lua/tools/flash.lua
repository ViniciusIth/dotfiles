return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        modes = {
            char = {
                enabled = false,
                keys = {}
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "zs",    mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "zS",    mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "zr",    mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "zR",    mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
