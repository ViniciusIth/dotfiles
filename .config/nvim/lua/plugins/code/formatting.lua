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
            vim.keymap.set("v", "<leader>ff", "'<,'>:Format<CR>", { desc = "Format file" })
        end
    },

    -- {
    --     'laytan/tailwind-sorter.nvim',
    --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    --     build = 'cd formatter && npm i && npm run build',
    --     config = true,
    -- },
}
