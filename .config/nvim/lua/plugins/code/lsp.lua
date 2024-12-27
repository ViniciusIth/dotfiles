return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            -- { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            -- import lspconfig plugin
            local lspconfig = require("lspconfig")

            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local keymap = vim.keymap -- for conciseness

            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                -- opts.desc = "Go to declaration"
                -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

                opts.desc = "Format file"
                keymap.set("n", "<leader>gf", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            require("mason-lspconfig").setup_handlers {
                -- Handler padrão para servidores simples
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach
                    })
                end,

                -- Configurações manuais para servidores mais complexos
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup(require("config.lsp.lua_ls")(capabilities, on_attach))
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup(require("config.lsp.gopls")(capabilities, on_attach))
                end,
                ["emmet_language_server"] = function()
                    require("lspconfig").emmet_language_server.setup(require("config.lsp.emmet")(capabilities, on_attach))
                end,
                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup(require("config.lsp.tsls")(capabilities, on_attach))
                end,
                ["rust_analyzer"] = function()
                    require("lspconfig").rust_analyzer.setup(require("config.lsp.rust")(capabilities, on_attach))
                end,
            }
        end
    },

    { -- Allows having lsp features inside markdown documents
        'jmbuhr/otter.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
       },
        opts = {},
        config = function()
            local otter = require("otter")
            vim.keymap.set("n", "<leader>moa", otter.activate, { desc = "[m]arkdown [o]tter [a]ctivate" })
        end
    },

    {
        'rust-lang/rust.vim',
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    },

    {
        'saecki/crates.nvim',
        ft = { "toml" },
        config = function()
            require("crates").setup {
                completion = {
                    cmp = {
                        enabled = true
                    },
                },
            }
            require('cmp').setup.buffer({
                sources = { { name = "crates" } }
            })
        end
    },


}
