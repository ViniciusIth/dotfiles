local flash = require("flash")

flash.setup({
    modes = {
        char = {
            enabled = false,
        },
    },
})

vim.keymap.set({ "n", "x", "o" }, "zs", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "zS", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "zr", flash.remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "zR", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })
