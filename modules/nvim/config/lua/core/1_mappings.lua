vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set({ "n", "v" }, "Y", '"+y', { desc = "Yank to system clipboard", noremap = true, silent = true })

-- Move in insert mode
vim.keymap.set('i', "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set('i', "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set('i', "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set('i', "<C-k>", "<Up>", { desc = "Move up" })

-- Move current line up/down without overwriting clipboard
vim.keymap.set("n", "<A-S-j>", ":move .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-S-k>", ":move .-2<CR>==", { desc = "Move line up", silent = true })

-- Move selected block up/down (visual mode), keep selection & reindent
vim.keymap.set("v", "<A-S-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<A-S-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })


-- Terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Escape terminal mode" })
vim.keymap.set('n', '<leader>t', ":terminal<CR>", { desc = "Open terminal" })
