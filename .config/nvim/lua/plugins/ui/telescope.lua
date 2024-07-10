return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim', 'airblade/vim-rooter' },
    config = function()
        vim.g.rooter_cd_cmd = 'lcd'

        require("telescope").setup {
            extensions = {
                repo = {
                    list = {
                        fd_opts = {
                            "--no-ignore-vcs",
                        },
                        search_dirs = {
                            "~/Projects",
                            "~/.config/nvim"
                        },
                        tail_path = true
                    },
                },
            },
        }
        require 'telescope'.load_extension 'repo'
    end
}
