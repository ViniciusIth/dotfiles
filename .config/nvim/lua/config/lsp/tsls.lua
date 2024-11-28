return function(capabilities, on_attach)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
            preferences = {
                -- other preferences...
                importModuleSpecifierPreference = 'non-relative',
                importModuleSpecifierEnding = 'minimal',
            },
        }
    }
end
