vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/catppuccin/nvim"},
  { src = "https://github.com/rebelot/kanagawa.nvim"},
  { src = "https://github.com/mcauley-penney/techbase.nvim" },

  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/stevearc/oil.nvim" },

  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/folke/flash.nvim" },
  {
    src = "https://github.com/jake-stewart/multicursor.nvim",
    version = "0c6ceae228bf209e8b8717df9de500770c4e7022",
  },
  {
    src = "https://github.com/kevinhwang91/promise-async",
    version = "119e8961014c9bfaf1487bf3c2a393d254f337e2",
  },
  {
    src = "https://github.com/kevinhwang91/nvim-ufo",
    version = "72d54c31079d38d8dfc5456131b1d0fb5c0264b0",
  },
  { src = "https://github.com/folke/which-key.nvim" },

  { 
    src = "https://github.com/nvim-treesitter/nvim-treesitter", 
    version = "main" 
  },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { 
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", 
    version = "main" 
  },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/leoluz/nvim-dap-go" },
  { src = "https://github.com/igorlfs/nvim-dap-view" },
  
  {
    src = "https://github.com/saghen/blink.cmp", 
    version = vim.version.range('*') 
  },
})

require("modules")

require("nvim-treesitter").install({
    "bash", "css", "csv", "diff", "dockerfile",
    "git_config", "git_rebase", "gitattributes",
    "gitcommit", "gitignore",
    "go", "gomod", "gosum", "gowork", "gotmpl",
    "html", "javascript", "json", "jsonnet",
    "lua", "make", "mermaid", "nix",
    "proto", "python", "rust", "sql",
    "templ", "terraform", "toml",
    "tsx", "typescript", "vim", "vimdoc",
    "vue", "yaml", "zig",
})
