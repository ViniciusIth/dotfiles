local ufo = require("ufo")

vim.o.foldcolumn = "0"
-- vim.o.foldcolumn = 'auto:9' -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

ufo.setup()
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
