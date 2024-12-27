return {
    -- {
    --     "3rd/image.nvim",
    --     ft = { "markdown", "quarto", "rmd" },
    --     config = function()
    --         require("image").setup({
    --             backend = "kitty",
    --             processor = "magick_cli", -- or "magick_cli"
    --             integrations = {
    --                 markdown = {
    --                     enabled = true,
    --                     clear_in_insert_mode = true,
    --                     download_remote_images = true,
    --                     only_render_image_at_cursor = false,
    --                     filetypes = { "markdown", "vimwiki", "quarto", "rmd" }, -- markdown extensions (ie. quarto) can go here
    --                 },
    --                 neorg = {
    --                     enabled = true,
    --                     filetypes = { "norg" },
    --                 },
    --                 typst = {
    --                     enabled = true,
    --                     filetypes = { "typst" },
    --                 },
    --                 html = {
    --                     enabled = false,
    --                 },
    --                 css = {
    --                     enabled = false,
    --                 },
    --             },
    --             max_width = nil,
    --             max_height = nil,
    --             max_width_window_percentage = nil,
    --             max_height_window_percentage = 50,
    --             window_overlap_clear_enabled = false,                                                        -- toggles images when windows are overlapped
    --             window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    --             editor_only_render_when_focused = false,                                                     -- auto show/hide images when the editor gains/looses focus
    --             tmux_show_only_in_active_window = false,                                                     -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    --             hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" }, -- render image files as images when opened
    --         })
    --     end
    -- },


    -- {
    --     'MeanderingProgrammer/render-markdown.nvim',
    --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    --     opts = {},
    --     ft = { 'markdown', 'quarto', 'rmd' },
    --     config = function()
    --         local rmarkdown = require('render-markdown')
    --         local image = require('image')
    --         vim.keymap.set('n', '<leader>mt', function()
    --             image.toggle()
    --             rmarkdown.toggle()
    --         end, { desc = '[m]arkdown [t]oggle' })
    --     end
    -- },

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

            -- keymap
            vim.keymap.set("n", "<leader>muo", "<cmd>URLOpenUnderCursor<CR>",
                { silent = true, noremap = true, desc = "Open URL under cursor" })


            url_open.setup({})
        end,
    },
}
