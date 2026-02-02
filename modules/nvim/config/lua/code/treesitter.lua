require('nvim-treesitter').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "cpp", "cmake", "go", "java", "javascript", "javascriptreact", "ledger",
    "lua", "markdown", "python", "rust", "typescript", "typescriptreact", "vue"
  },
  callback = function() vim.treesitter.start() end,
})
