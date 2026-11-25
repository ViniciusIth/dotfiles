local mini_files = require("mini.files")
mini_files.setup({
      options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = false,
    -- Whether to use for editing directories
    use_as_default_explorer = false,
  },
})

vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Toggle mini files" })
