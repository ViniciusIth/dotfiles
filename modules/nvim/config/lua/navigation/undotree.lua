vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd("Undotree")
end, { desc = "Undotree toggle" })
