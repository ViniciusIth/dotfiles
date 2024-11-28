vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })

vim.keymap.set('i', "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set('i', "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set('i', "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set('i', "<C-k>", "<Up>", { desc = "Move up" })

-- OpenpNvimTree
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Open UndoTree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- Terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Escape terminal mode" })
vim.keymap.set('n', '<leader>t', ":terminal<CR>", { desc = "Open terminal" })
