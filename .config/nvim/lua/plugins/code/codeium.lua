return {
    'Exafunction/codeium.vim',
    config = function()
        -- Toggle codeium on normal mode
        vim.keymap.set('n', '<leader>cd', ":CodeiumToggle<CR>", { silent = false, desc = "Toggle codeium" })
        vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true }, "")
        vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
}
