local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
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
})


vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set('n', '<leader>ps', ":Telescope repo list<CR>", { silent = true, desc = "Telescope repo list" })
