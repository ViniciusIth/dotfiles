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

            lspconfig["lua_ls"].setup(require("config.lsp.lua_ls")(capabilities, on_attach))
            lspconfig["gopls"].setup(require("config.lsp.gopls")(capabilities, on_attach))
            lspconfig["html"].setup(require("config.lsp.html")(capabilities, on_attach))
            lspconfig["htmx"].setup(require("config.lsp.html")(capabilities, on_attach))
            lspconfig["emmet_language_server"].setup(require("config.lsp.emmet")(capabilities, on_attach))
            lspconfig["ts_ls"].setup(require("config.lsp.tsls")(capabilities, on_attach))
            lspconfig["rust_analyzer"].setup(require("config.lsp.rust")(capabilities, on_attach))

            lspconfig["jsonls"].setup({ capabilities = capabilities, on_attach = on_attach, filetypes = { "jsonc" } })
            lspconfig["sqlls"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["svelte"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["tailwindcss"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["templ"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["cssls"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["r_language_server"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["angularls"].setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig["volar"].setup({ capabilities = capabilities, on_attach = on_attach })
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

    -- Rust bullshit
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^5', -- Recommended
    --     lazy = false, -- This plugin is already lazy
    --     ft = "rust",
    --     config = function()
    --         local mason_registry = require('mason-registry')
    --         local codelldb = mason_registry.get_package("codelldb")
    --         local extension_path = codelldb:get_install_path() .. "/extension/"
    --         local codelldb_path = extension_path .. "adapter/codelldb"
    --         -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    --         -- If you are on Linux, replace the line above with the line below:
    --         local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    --         local cfg = require('rustaceanvim.config')
    --
    --         vim.g.rustaceanvim = {
    --             dap = {
    --                 adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    --             },
    --         }
    --
    --         on_attach
    --     end
    -- },

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
