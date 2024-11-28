return {
    {
        "3rd/image.nvim",
        config = function()
            require("image").setup({
                backend = "kitty",
                processor = "magick_rock", -- or "magick_cli"
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        filetypes = { "norg" },
                    },
                    typst = {
                        enabled = true,
                        filetypes = { "typst" },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false,                                                        -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                editor_only_render_when_focused = false,                                                     -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false,                                                     -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" }, -- render image files as images when opened
            })
        end
    },

    { -- Allows having lsp features inside markdown documents
        'jmbuhr/otter.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {},
        config = function()
            local otter = require("otter")
            vim.keymap.set("n", "<leader>moa", otter.activate, { desc = "[m]arkdown [o]tter [a]ctivate" })
        end

    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        opts = {},
        config = function()
            local rmarkdown = require('render-markdown')
            vim.keymap.set('n', '<leader>mt', function()
                rmarkdown.toggle()
            end, { desc = '[m]arkdown [t]oggle' })
        end
    },
    {
        "sontungexpt/url-open",
        branch = "mini",
        event = "VeryLazy",
        cmd = "URLOpenUnderCursor",
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then
                return
            end
            url_open.setup({})
        end,
    },

    -- { -- paste an image from the clipboard or drag-and-drop
    --     'HakonHarnes/img-clip.nvim',
    --     event = 'BufEnter',
    --     ft = { 'markdown', 'quarto', 'latex' },
    --     opts = {
    --         default = {
    --             dir_path = 'img',
    --         },
    --         filetypes = {
    --             markdown = {
    --                 url_encode_path = true,
    --                 template = '![$CURSOR]($FILE_PATH)',
    --                 drag_and_drop = {
    --                     download_images = false,
    --                 },
    --             },
    --             quarto = {
    --                 url_encode_path = true,
    --                 template = '![$CURSOR]($FILE_PATH)',
    --                 drag_and_drop = {
    --                     download_images = false,
    --                 },
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         require('img-clip').setup(opts)
    --         vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
    --     end,
    -- },
}
