return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim', 'airblade/vim-rooter' },
    config = function()
        vim.g.rooter_cd_cmd = 'lcd'

        require("telescope").setup {
            pickers = {
                find_files = {
                    hidden = true
                },
                live_grep = {
                    additional_args = function(_)
                        return { "--hidden" }
                    end
                }
            },
            defaults = {
                file_ignore_patterns = { 'node_modules', '.git', '.venv' }
            },
            extensions = {
                repo = {
                    list = {
                        fd_opts = {
                            "--no-ignore-vcs",
                        },
                        search_dirs = {
                            "~/Projects",
                            "~/Documents"
                        },
                        tail_path = false
                    },
                },
            },
        }

        require 'telescope'.load_extension 'repo'

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags" })
        vim.keymap.set('n', '<leader>ps', ":Telescope repo list<CR>", { silent = true, desc = "Telescope repo list" })
    end
}
