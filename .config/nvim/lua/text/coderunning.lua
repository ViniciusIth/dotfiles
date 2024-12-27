return {
    {
        "michaelb/sniprun",
        branch = "master",

        build = "sh install.sh 1",
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

        dependencies = {
            "rcarriga/nvim-notify"
        },

        config = function()
            require("sniprun").setup({
                display = { "NvimNotify" },
                display_options = {
                    notification_timeout = 5,       -- in seconds
                    notification_render = "default" -- nvim-notify render style
                },

                interpreter_options = {
                    Go_original = {
                        compiler = "gccgo"
                    }
                }
            })

            vim.g.markdown_fenced_languages = { "javascript", "typescript", "bash", "lua", "go", "rust", "c", "cpp" }

            vim.keymap.set("n", "<leader>sr", "<cmd>SnipRun<cr>",
                { silent = true, noremap = true, desc = "[S]nip[R]un" })
            vim.keymap.set("v", "<leader>sr", "<cmd>SnipRun<cr>",
                { silent = true, noremap = true, desc = "[S]nip[R]un" })
        end,
    },

    {
        "R-nvim/R.nvim",
        -- Only required if you also set defaults.lazy = true
        lazy = false,
        -- R.nvim is still young and we may make some breaking changes from time
        -- to time. For now we recommend pinning to the latest minor version
        -- like so:
        version = "~0.1.0",
        config = function()
            -- Create a table with the options to be passed to setup()
            local opts = {
                hook = {
                    on_filetype = function()
                        vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                        vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                    end
                },
                R_args = { "--quiet", "--no-save" },
                min_editor_width = 72,
                rconsole_width = 78,
                objbr_mappings = {                                  -- Object browser keymap
                    c = 'class',                                    -- Call R functions
                    ['<localleader>gg'] = 'head({object}, n = 15)', -- Use {object} notation to write arbitrary R code.
                    v = function()
                        -- Run lua functions
                        require('r.browser').toggle_view()
                    end
                },
                disable_cmds = {
                    "RClearConsole",
                    "RCustomStart",
                    "RSPlot",
                    "RSaveClose",
                },
            }
            -- Check if the environment variable "R_AUTO_START" exists.
            -- If using fish shell, you could put in your config.fish:
            -- alias r "R_AUTO_START=true nvim"
            if vim.env.R_AUTO_START == "true" then
                opts.auto_start = "on startup"
                opts.objbr_auto_start = true
            end
            require("r").setup(opts)
        end,
    },
}
