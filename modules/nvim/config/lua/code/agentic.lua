local agentic = require("agentic")

agentic.setup({
    provider = "codex-acp", 
    diff_preview = {
        enabled = true, 
        layout = "split", 
        center_on_navigate_hunks = true,
    }
})

local agentic = require("agentic")

-- Toggle chat
vim.keymap.set({ "n" }, "<leader>at", function()
  agentic.toggle()
end, { desc = "Toggle Agentic Chat" })

-- Add selection/file to context
vim.keymap.set({ "n" }, "<leader>ac", function()
  agentic.add_selection_or_file_to_context()
end, { desc = "Add to Agentic Context" })

-- New session
vim.keymap.set({ "n" }, "<leader>a<C-r>", function()
  agentic.new_session()
end, { desc = "New Agentic Session" })

-- Restore session
vim.keymap.set({ "n" }, "<leader>ar", function()
  agentic.restore_session()
end, { desc = "Restore Agentic Session", silent = true })

-- Current line diagnostics
vim.keymap.set("n", "<leader>ad", function()
  agentic.add_current_line_diagnostics()
end, { desc = "Add line diagnostics" })

-- Buffer diagnostics
vim.keymap.set("n", "<leader>aD", function()
  agentic.add_buffer_diagnostics()
end, { desc = "Add buffer diagnostics" })

vim.keymap.set("n", "<leader>ap", function()
  require("agentic").switch_provider()
end)
