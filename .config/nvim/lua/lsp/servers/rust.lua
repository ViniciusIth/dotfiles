return function(capabilities, on_attach)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            rust_analyzer = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                procMacro = {
                    enable = true
                },
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                autoImportCompletions = false,
                reportMissingImports = true,
                followImportForHints = true,
                cargo = {
                    allFeatures = true,
                },
                checkOnSave = {
                    command = "cargo clippy",
                },
            }
        },
        root_dir = function()
            return vim.fn.getcwd()
        end,
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
    }
end
