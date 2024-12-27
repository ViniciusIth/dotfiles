return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query", "elixir", "heex",
                    "javascript", "html", "templ", "r", "latex", "markdown",
                    "markdown_inline", "css", "json", "jsonc", "svelte", "rust"
                },
                sync_install = false,
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
            })
        end
    },
    {
        "mhartington/formatter.nvim",
        config = function()
            vim.keymap.set("n", "<leader>ff", ":Format<CR>", { desc = "Format file" })
            vim.keymap.set("v", "<leader>ff", ":'<,'>Format<CR>", { desc = "Format file" })
        end
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = {
                    "*",

                    -- Excluded filteypes.
                    "!lazy", -- Commit hashes get highlighted sometimes.
                },
                user_default_options = {
                    RGB = true,      -- #RGB hex codes.
                    RRGGBB = true,   -- #RRGGBB hex codes.
                    RRGGBBAA = true, -- #RRGGBBAA hex codes.
                    AARRGGBB = true, -- 0xAARRGGBB hex codes.

                    -- "Name" codes like Blue or blue. It is pretty annoying when you have maps with
                    -- 'blue = color_hex': you get two previews, one for the key and one for the value.
                    names = false,

                    rgb_fn = true, -- CSS rgb() and rgba() functions.
                    hsl_fn = true, -- CSS hsl() and hsla() functions.
                    css = true,    -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB.
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn.
                    tailwind = true,

                    mode = "virtualtext",
                    virtualtext = "■",
                },
            })
        end,
        event = { "BufReadPre" },
    }
}
