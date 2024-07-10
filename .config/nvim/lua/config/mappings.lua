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

-- Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set('n', '<leader>ps', ":Telescope repo list<CR>", { silent = true, desc = "Telescope repo list" })

-- Terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Escape terminal mode" })
vim.keymap.set('n', '<leader>t', ":terminal<CR>", { desc = "Open terminal" })
