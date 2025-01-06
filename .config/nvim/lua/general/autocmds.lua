-- Função para verificar se o último buffer/janela aberto é o nvim-tree
local function is_last_window()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    return #wins == 1 and vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(wins[1])):match("NvimTree")
end

-- Cria um autocmd para detectar o fechamento da última janela
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        -- Se a última janela não for o nvim-tree, abre o nvim-tree ao fechar a última janela
        if #vim.api.nvim_list_wins() == 1 and not is_last_window() then
            vim.cmd("NvimTreeOpen")
        end
    end,
})

-- Define o comportamento do :q no nvim-tree
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "NvimTree_*",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local is_empty = vim.fn.empty(vim.fn.filter(vim.api.nvim_list_bufs(), 'v:val != ' .. buf)) == 1

        -- Se o nvim-tree for o único buffer aberto, ele fecha normalmente
        if is_empty then
            vim.cmd("quit")
        end
    end,
})

-- Changes settings when editting a markdown file
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        -- vim.opt_local.spell = true
    end,
})
