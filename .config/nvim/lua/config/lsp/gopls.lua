local util = require('lspconfig.util')

return function(capabilities, on_attach)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = function(fname)
            return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
        end,
    }
end
