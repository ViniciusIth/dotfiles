local blink = require("blink.cmp")

blink.setup({
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
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
        ghost_text = {
            enabled = true,
            show_with_menu = false,
        },
        menu = {
            auto_show = false,
            border = "rounded",
        },
    },
    signature = {
        enabled = true,
    },
    fuzzy = {
        implementation = "prefer_rust", 
          prebuilt_binaries = {
            download = true,
        }
    },
})
