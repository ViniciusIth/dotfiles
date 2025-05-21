return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "lua_ls", -- lua language server
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                },
            })
        end,
    },

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
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            require("mason-lspconfig").setup_handlers {
                -- Handler padrão para servidores simples
                function(server_name)
                    -- Print server name
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach
                    })
                end,

                -- Configurações manuais para servidores mais complexos
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup(require("lsp.servers.lua_ls")(capabilities, on_attach))
                end,
                ["gopls"] = function()
                    lspconfig.gopls.setup(require("lsp.servers.gopls")(capabilities, on_attach))
                end,
                ["emmet_language_server"] = function()
                    lspconfig.emmet_language_server.setup(require("lsp.servers.emmet")(capabilities, on_attach))
                end,
                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup(require("lsp.servers.rust")(capabilities, on_attach))
                end,
            }
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        -- Ensure it loads for relevant filetypes and after nvim-lspconfig
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig", -- ⭐ Make it depend on nvim-lspconfig
        },
        config = function()
            local on_attach = function(_ --[[ client ]], bufnr)
                local keymap = vim.keymap
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                keymap.set("n", "<leader>gf", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end

            require("typescript-tools").setup {
                on_attach = on_attach,
                settings = {
                    separate_diagnostic_server = true,
                    expose_as_code_action = "all",
                    tsserver_plugins = {},
                },
            }
        end,
    },
}
