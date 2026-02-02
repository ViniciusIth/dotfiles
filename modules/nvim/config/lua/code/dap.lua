local map = vim.keymap.set

-- #region DAP
require("nvim-dap-virtual-text").setup()
local dap = require("dap")

map("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
map("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
map("n", "<leader>dr", dap.restart, { desc = "Restart Debugger" })

-- Stepping
map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>du", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })

-- Breakpoints
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })

-- UI
map("n", "<leader>dd", function() require("dap-view").toggle() end, { desc = "DAP UI" })
map("n", "<leader>dp", dap.repl.toggle, { desc = "Toggle REPL" })

-- Stack Navigation
map("n", "<leader>dk", dap.up, { desc = "Up Stack" })
map("n", "<leader>dj", dap.down, { desc = "Down Stack" })


-- #endregion


-- #region DAP GO
local dap_go = require("dap-go")

dap_go.setup({
    silent = true,
    dap_configurations = {
        {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },
    delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
    },
    tests = {
        verbose = false,
    },
})

map("n", "<leader>dt", function() dap_go.debug_test() end, { desc = "Debug Test" })
map("n", "<leader>dL", function() dap_go.debug_last() end, { desc = "Debug Last" })
map("n", "<leader>dR", function() dap_go.debug_remote() end, { desc = "Debug Remote" })
-- #endregion


-- #region DAP UI
local dv = require("dap-view")
dv.setup()

dap.listeners.before.attach["dap-view"] = function() dv.open() end
dap.listeners.before.launch["dap-view"] = function() dv.open() end
dap.listeners.before.event_terminated["dap-view"] = function() dv.close() end
dap.listeners.before.event_exited["dap-view"] = function() dv.close() end

vim.keymap.set("n", "<leader>du", function() dv.toggle() end, { desc = "Dap UI" })
-- #endregion
