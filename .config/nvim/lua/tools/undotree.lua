return {
    "mbbill/undotree",
    lazy = false,
    config = function()
        local o = vim.opt

        -- Disable swap and enable undofiles
        o.swapfile = false
        o.backup = false
        o.undofile = true
        o.undodir = vim.fn.stdpath('config') .. "/.undodir"

        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle UndoTree" })
    end
}
