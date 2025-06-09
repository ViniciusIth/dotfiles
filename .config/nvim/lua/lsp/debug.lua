return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
        },
        lazy = true,
        config = function()
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup()
        end,
        keys = {
            { "<leader>d",  name = "+debug" }, -- group all under <leader>d
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
            { "<leader>dR", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            { "<leader>dT", function() require("dap").terminate() end,                                            desc = "Terminate" },
        },
    },
    {
        "igorlfs/nvim-dap-view",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
        opts = {},
        config = function(_, opts)
            local dap, dv = require("dap"), require("dap-view")
            dap.listeners.before.attach["dap-view-config"] = function()
                dv.open()
            end
            dap.listeners.before.launch["dap-view-config"] = function()
                dv.open()
            end
            dap.listeners.before.event_terminated["dap-view-config"] = function()
                dv.close()
            end
            dap.listeners.before.event_exited["dap-view-config"] = function()
                dv.close()
            end

            require("dap-view").setup(opts)
        end,
        keys = {
            { "<leader>du", function() require("dap-view").toggle({}) end, desc = "Dap UI" },
        }
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
        ft = { "go" },
        keys = {
            {
                "<leader>dt",
                function() require("dap-go").debug_test() end,
                desc = "Debug Test"
            },
            {
                "<leader>dl",
                function() require("dap-go").debug_last() end,
                desc = "Debug Last"
            },
            {
                "<leader>dr",
                function() require("dap-go").debug_remote() end,
                desc = "Debug Remote"
            },
        },
        opts = {
            silent = true,
            dap_configurations = {
                {
                    -- Must be "go" or it will be ignored by the plugin
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
            delve = {
                -- the path to the executable dlv which will be used for debugging.
                -- by default, this is the "dlv" executable on your PATH.
                path = "dlv",
                -- time to wait for delve to initialize the debug session.
                -- default to 20 seconds
                initialize_timeout_sec = 20,
                -- a string that defines the port to start delve debugger.
                -- default to string "${port}" which instructs nvim-dap
                -- to start the process in a random available port.
                -- if you set a port in your debug configuration, its value will be
                -- assigned dynamically.
                port = "${port}",
                -- additional args to pass to dlv
                args = {},
                -- the build flags that are passed to delve.
                -- defaults to empty string, but can be used to provide flags
                -- such as "-tags=unit" to make sure the test suite is
                -- compiled during debugging, for example.
                -- passing build flags using args is ineffective, as those are
                -- ignored by delve in dap mode.
                -- avaliable ui interactive function to prompt for arguments get_arguments
                build_flags = {},
                -- whether the dlv process to be created detached or not. there is
                -- an issue on delve versions < 1.24.0 for Windows where this needs to be
                -- set to false, otherwise the dlv server creation will fail.
                -- avaliable ui interactive function to prompt for build flags: get_build_flags
                detached = vim.fn.has("win32") == 0,
                -- the current working directory to run dlv from, if other than
                -- the current working directory.
                cwd = nil,
            },
            tests = {
                -- enables verbosity when running the test.
                verbose = false,
            }

        },
        config = function(_, opts)
            require("dap-go").setup(opts)
        end
    },
}
