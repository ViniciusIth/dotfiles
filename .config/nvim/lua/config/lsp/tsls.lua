return function(capabilities, on_attach)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
            preferences = {
                importModuleSpecifierPreference = 'non-relative',
                importModuleSpecifierEnding = 'minimal',
            },
        }
    }
end
