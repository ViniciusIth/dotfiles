return {
    'Exafunction/codeium.vim',
    event = "BufEnter",
    config = function()
        vim.g.codeium_disable_bindings = 1

        -- Toggle codeium on normal mode
        vim.keymap.set('n', '<leader>cd', ":CodeiumToggle<CR>", { silent = false, desc = "Toggle codeium" })
        vim.keymap.set('i', '<C-k>', function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
}
