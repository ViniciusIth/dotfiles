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
