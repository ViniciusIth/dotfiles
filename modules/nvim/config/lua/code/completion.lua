local blink = require("blink.cmp")

blink.setup({
    keymap = {
        preset = "default",

        -- Trigger completion manually
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

        -- Confirm selection
        ["<CR>"] = { "accept", "fallback" },

        -- Navigation
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
        },
        menu = {
            border = "rounded",
        },
    },

    signature = {
        enabled = true,
    },
})
