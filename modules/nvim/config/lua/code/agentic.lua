local agentic = require("agentic")

agentic.setup({
    provider = "opencode-acp", 
    diff_preview = {
        enabled = true, 
        layout = "split", 
        center_on_navigate_hunks = true,
    }
})

local agentic = require("agentic")

vim.keymap.set({ "n" }, "<leader>at", agentic.toggle, { desc = "[Agentic] Toggle Chat" })
vim.keymap.set({ "n", "v" }, "<leader>ac", agentic.add_selection_or_file_to_context, { desc = "[Agentic] Add to Context" })
vim.keymap.set({ "n" }, "<leader>a<C-r>", agentic.new_session, { desc = "[Agentic] New Session" })
vim.keymap.set({ "n" }, "<leader>ar", agentic.restore_session, { desc = "[Agentic] Restore Session", silent = true })
vim.keymap.set("n", "<leader>ad", agentic.add_current_line_diagnostics, { desc = "[Agentic] Add line diagnostics" })
vim.keymap.set("n", "<leader>aD", agentic.add_buffer_diagnostics, { desc = "[Agentic] Add buffer diagnostics" })
vim.keymap.set("n", "<leader>ap", agentic.switch_provider, { desc = "[Agentic] Switch provider" })
